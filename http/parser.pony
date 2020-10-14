use "buffered"
use "net"
use "encode/base64"


// TODO: This is loosely based off of the code in the original http code but I'm
// curious if it's possible to do something more interesting here with respect to the
// state machine that this represents.

class Parser
  var _response: Response iso = Response

  var _state: _ParserState
  var _length: USize = 0

  new request(length: USize = 0) =>
    _length = length
    _state = _ExpectRequest

  new response(length: USize = 0) =>
    _length = length
    _state = _ExpectResponse

  fun ref completed_response(): Response val =>
    let completed = _response = Response
    consume completed

  fun ref parse(buffer: Reader): ParseResult =>
    match _state
      | _ExpectResponse => _parse_response(buffer)
      | _ExpectHeaders => _parse_headers(buffer)
      | _ExpectBody => _parse_body(buffer)
      | _ExpectReady => ParseComplete
    else
      ParseError(ReasonUnknown)
    end

  fun ref _parse_response(buffer: Reader): ParseResult =>
    """
    Look for "<Proto> <Code> <Description>", the first line of an
    HTTP 'response' message.
    """
    try
      let line = buffer.line()?

      let proto_end = line.find(" ")?
      _response.protocol = line.substring(0, proto_end)
      _response.status = StatusParser.parse(line.read_int[U16](proto_end + 1)?._1)?

      _state = _ExpectHeaders
      parse(buffer)
    else
      ParseError(ReasonBadStatusLine)
    end

  fun ref _parse_headers(buffer: Reader): ParseResult =>
    """
    Look for: "<Key>:<Value>" or the empty line that marks the end of
    all the headers.
    """
    try
      let line = buffer.line()?
      if line.size() == 0 then
        // An empty line marks the end of the headers. Set state
        // appropriately.
        _set_header_end()
        parse(buffer)
      else
        // A non-empty line *must* be a header. error if not.
        try
          _process_header(consume line)?
          parse(buffer)
        else
          return ParseError(ReasonBadHeader)
        end
      end
    else
      return ParseInProgress
    end

  fun ref _process_header(line: String)? =>
    """
    Save a header value. Raise an error on not finding the colon
    or can't interpret the value.
    """
    let i = line.find(":")?

    let unstripped_key = line.substring(0, i)
    unstripped_key.strip()
    let key: String val = consume unstripped_key

    let unstripped_value = line.substring(i + 1)
    unstripped_value.strip()
    let value: String val = consume unstripped_value

    // TODO: There is probably more to do here.
    match key.lower()
    | "content-length" =>
      _length = value.read_int[USize]()?._1
    end

    _response._add_header(key, value)

  fun ref _set_header_end() =>
    """
    Line size is zero, so we have reached the end of the headers.
    Certain status codes mean there is no body.
    """
    if
      (_response.status is NoContent)
        or (_response.status is NotModified)
        or ((_response.status.code() > 0) and (_response.status.code() < 200))
    then
      _state = _ExpectReady
    else
      if _length == 0 then
          _state = _ExpectReady
        else
          _state = _ExpectBody
        end
    end

  fun ref _parse_body(buffer: Reader): ParseResult =>
     """
    Look for `_length` bytes set by having seen a `Content-Length`
    header. We may not see it all at once but we process the lesser of
    what we need and what is available in the buffer.
    """
    let available = buffer.size()
    let usable = available.min(_length)

    try
      let bytes = buffer.block(usable)?
      let body = recover val consume bytes end
      _length = _length - usable

      if _length <= 0 then
        _response._set_body(body)
        _state = _ExpectReady
        return parse(buffer)
      end
    end

    ParseInProgress


// The parser internal state indicates what it expects to see next
// in the input stream.

primitive _ExpectRequest
primitive _ExpectResponse
primitive _ExpectHeaders
primitive _ExpectContentLength
primitive _ExpectBody
primitive _ExpectReady
primitive _ExpectError

type _ParserState is
  ( _ExpectRequest       // Request method and URL
  | _ExpectResponse      // Response status
  | _ExpectHeaders       // More headers
  | _ExpectContentLength // Body text, limited by Content-Length
  | _ExpectBody          // Any body, which might not be there
  | _ExpectReady         // All done with the message
  | _ExpectError         // Not valid HTTP format
  )

primitive ParseComplete
  fun string(): String iso^ =>
    "ParseComplete".string()

primitive ParseInProgress
  fun string(): String iso^ =>
    "ParseInProgress".string()

class val ParseError
  let reason: Reason
  new val create(reason': Reason) =>
    reason = reason'

  fun string(): String iso^ =>
    "ParseError".string()

type ParseResult is (ParseComplete | ParseInProgress | ParseError)

primitive ReasonUnknown
primitive ReasonBadStatusLine
primitive ReasonBadHeader
primitive ReasonBadBody

type Reason is (
  ReasonUnknown | ReasonBadStatusLine | ReasonBadHeader | ReasonBadBody
)
