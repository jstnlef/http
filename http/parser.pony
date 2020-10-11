use "buffered"
use "net"
use "encode/base64"


class Parser
  var _response: Response iso = Response

  var _state: _ParsingState
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
      // | _ExpectRequest => _parse_request(buffer)
      | _ExpectResponse => _parse_response(buffer)
      | _ExpectHeaders => _parse_headers(buffer)
      | _ExpectBody => _parse_body(buffer)
      | _ExpectContentLength => _parse_content_length(buffer)
    else
      ParseError
    end


//   fun ref _deliver() =>
//     """
//     The parser is finished with the message headers so we can push it
//     to the `HTTPSession`. The body may come later.
//     """
//     let body_follows = match _payload.transfer_mode
//       | ChunkedTransfer => true
//     else
//       (_expected_length > 0)
//     end

//     // Set up `_payload` for the next message.
//     let payload = _payload = Payload._empty(_client)
//     _session._deliver(consume payload)
//     if not body_follows then
//       restart()
//     end

//   fun ref restart() =>
//     """
//     Restart parser state for the next message. It will be of the same
//     kind as the last one.
//     """
//     _expected_length = 0
//     _transfer_mode = OneshotTransfer
//     _chunk_end = false

//     _state = if _client then
//       _ExpectResponse
//     else
//       _ExpectRequest
//     end

//   fun ref closed(buffer: Reader) =>
//     """
//     The connection has closed, which may signal that all remaining data is the
//     payload body.
//     """
//     if _state is _ExpectBody then
//       _expected_length = buffer.size()

//       try
//         let bytes = buffer.block(_expected_length)?
//         let chunk: ByteSeq = recover val consume bytes end
//         match _payload.transfer_mode
//         | OneshotTransfer => _payload.add_chunk(chunk)
//         else
//           _session._chunk(chunk)
//         end
//         _state = _ExpectReady
//       end
//     end

  // fun ref _parse_request(buffer: Reader): (ParseError | None) =>
  //   """
  //   Look for "<Method> <URL> <Proto>", the first line of an HTTP
  //   'request' message.
  //   """
  //   try
  //     let line = buffer.line()?
  //     let method_end = line.find(" ")?
  //     _payload.method = line.substring(0, method_end)

  //     let url_end = line.find(" ", method_end + 1)?
  //     _payload.url = URL.valid(line.substring(method_end + 1, url_end))?
  //     _payload.proto = line.substring(url_end + 1)

  //     _state = _ExpectHeaders
  //     parse(buffer)
  //   else
  //     ParseError
  //   end

  fun ref _parse_response(buffer: Reader): ParseResult =>
    """
    Look for "<Proto> <Code> <Description>", the first line of an
    HTTP 'response' message.
    """
    try
      let line = buffer.line()?

      let proto_end = line.find(" ")?
      _response.proto = line.substring(0, proto_end)
      _response.status = StatusParser.parse(line.read_int[U16](proto_end + 1)?._1)?

      _state = _ExpectHeaders
      parse(buffer)
    else
      ParseError
    end

  fun ref _parse_headers(buffer: Reader): ParseResult =>
    """
    Look for: "<Key>:<Value>" or the empty line that marks the end of
    all the headers.
    """
    while true do
      // Try to get another line out of the available buffer.
      // If this fails it is not a syntax error; we just wait for more.
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
          else
            return ParseError
          end
        end
      else
        return ParseInProgress
      end
    end
    ParseError

  fun ref _process_header(line: String)? =>
    """
    Save a header value. Raise an error on not finding the colon
    or can't interpret the value.
    """
    error
//     let i = line.find(":")?
//     let key = line.substring(0, i)
//     key.strip()
//     let key2: String val = consume key
//     let value = line.substring(i + 1)
//     value.strip()
//     let value2: String val = consume value

//     // Examine certain headers describing the encoding.
//     match key2.lower()
//     | "content-length" => // Explicit body length.
//       _expected_length = value2.read_int[USize]()?._1
//       // On the receiving end, there is no difference
//       // between Oneshot and Stream transfers except how
//       // we store it. TODO eliminate this?
//       _transfer_mode =
//         if _expected_length > 10_000 then
//           StreamTransfer
//         else
//           OneshotTransfer
//         end
//       _payload.transfer_mode = _transfer_mode

//     | "transfer-encoding" => // Incremental body lengths.
//       try
//         value2.find("chunked")?
//         _transfer_mode = ChunkedTransfer
//         _payload.transfer_mode = _transfer_mode
//       else
//         _state = _ExpectError
//       end

//     | "Host" =>
//       // TODO: set url host and service
//       None

//     | "authorization" => _setauth(value2)

//     end // match certain headers

//     _payload(key2) = value2

//   fun ref _setauth(auth: String) =>
//     """
//     Fill in username and password from an authentication header.
//     """
//     try
//       let parts = auth.split(" ")
//       let authscheme = parts(0)?
//       match authscheme.lower()
//       | "basic" =>
//         let autharg = parts(1)?
//         let userpass = Base64.decode[String iso](autharg)?
//         let uparts = userpass.split(":")
//         _payload.username = uparts(0)?
//         _payload.password = uparts(1)?
//       end
//     end

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
          _ExpectReady
        else
          _ExpectBody
        end
    end

  fun ref _parse_body(buffer: Reader): ParseResult =>
    ParseError

  fun ref _parse_content_length(buffer: Reader): ParseResult =>
    """
    Look for `_expected_length` bytes set by having seen a `Content-Length`
    header. We may not see it all at once but we process the lesser of
    what we need and what is available in the buffer.
    """
    ParseError
//     let available = buffer.size()
//     let usable = available.min(_expected_length)

//     try
//       let bytes = buffer.block(usable)?
//       let body = recover val consume bytes end
//       _expected_length = _expected_length - usable
//       // in streaming mode we already have a new unrelated payload in _payload
//       // so we need to keep track of the current transfer-mode via _transfer_mode
//       match _transfer_mode
//       | OneshotTransfer =>
//         // in oneshot transfer we actually fill the body of the payload
//         _payload.add_chunk(body)
//       else
//         _session._chunk(body)
//       end

//       // All done with this message if we have processed the entire body.
//       if _expected_length == 0 then
//         match _transfer_mode
//         | OneshotTransfer =>
//           // we have all the body, finally deliver it
//           _deliver()
//         else
//           // explicitly finish the session in chunked and stream mode
//           _session._finish()
//         end
//         restart()
//       end
//     end

//   fun ref _parse_chunk_start(buffer: Reader): (ParseError | None) =>
//     """
//     Look for the beginning of a chunk, which is a length in hex on a line
//     terminated by CRLF. An explicit length of zero marks the end of
//     the entire chunked message body.
//     """
//     let line = try
//       buffer.line()?
//     else
//       return ParseError
//     end

//     if line.size() > 0
//     then
//       // This should be the length of the next chunk.
//       _expected_length = try
//         line.read_int[USize](0, 16)?._1
//       else
//         return ParseError
//       end
//       // A chunk explicitly of length zero marks the end of the body.
//       if _expected_length > 0 then
//         _state = _ExpectChunk
//       else
//         // We already have the CRLF after the zero, so we are all done.
//         _session._finish()
//         restart()
//       end

//       parse(buffer)
//     else
//       // Anything other than a length is an error.
//       _expected_length = 0
//       _state = _ExpectError
//       ParseError
//     end

//   fun ref _parse_chunk(buffer: Reader) =>
//     """
//     Look for a chunk of the size set by `_parse_chunk_start`. We may
//     not see it all at once but we process the lesser of what we need
//     and what is available in the buffer. ChunkedTransfer mode always
//     delivers directly to the HTTPSession handler.
//     """
//     let available = buffer.size()
//     let usable = available.min(_expected_length)
//     try
//       let chunk = buffer.block(usable)?
//       _session._chunk(consume chunk)
//       _expected_length = _expected_length - usable

//       // If we have all of the chunk, look for the trailing CRLF.
//       // Otherwise we will keep working on this chunk.
//       if _expected_length == 0 then
//         _state = _ExpectChunkEnd
//         parse(buffer)
//         end
//     end

//   fun ref _parse_chunk_end(buffer: Reader) =>
//     """
//     Look for the CRLF that ends every chunk. AFter that we look for
//     the next chunk, or that was the special ending chunk.
//     """
//     try
//       let line = buffer.line()?
//       if _chunk_end then
//         _session._finish()
//         restart()
//       else
//         _state = _ExpectChunkStart
//         parse(buffer)
//       end
//     end


// The parser internal state indicates what it expects to see next
// in the input stream.

primitive _ExpectRequest
primitive _ExpectResponse
primitive _ExpectHeaders
primitive _ExpectContentLength
primitive _ExpectBody
primitive _ExpectReady
primitive _ExpectError

type _ParsingState is
  ( _ExpectRequest       // Request method and URL
  | _ExpectResponse      // Response status
  | _ExpectHeaders       // More headers
  | _ExpectContentLength // Body text, limited by Content-Length
  | _ExpectBody          // Any body, which might not be there
  | _ExpectReady         // All done with the message
  | _ExpectError         // Not valid HTTP format
  )

primitive ParseComplete
primitive ParseInProgress
primitive ParseError

type ParseResult is (ParseComplete | ParseInProgress | ParseError)
