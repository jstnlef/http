use "regex"

class val Url
  var scheme: Scheme = HTTP
  var host: Host = ""
  var port: Port = scheme.default_port()
  var path: Path = ""
  var query: Query = ""
  var fragment: Fragment = ""

  new val create(url: String)? =>
    _parse(url)?

  fun ref _parse(url: String)? =>
    let reg = UriRegex.uri()?
    let groups = reg(url)?.groups()

    scheme = match groups(0)?
      | "http" => HTTP
      | "https" => HTTPS
      else error
    end

    let authority = groups(1)?
    let split_auth = authority.split(":")

    host = split_auth(0)?
    port = try
      split_auth(1)?.u16()?
    else
      scheme.default_port()
    end

    path = groups(2)?
    query = groups(3)?
    fragment = groups(4)?

  // TODO: Need to figure out if this is the right way to do this.
  fun string(): String iso^ =>
    let string_str = scheme.string()

    let len: USize = string_str.size() + 3 + host.size()
        + 6 + path.size() + 1 + query.size() + 1 + fragment.size()
    let s = recover String(len) end

    s.append(scheme.string())
    s.append("://")

    if host.size() > 0 then
      s.append(host)
    end

    // Do not output port if it's the scheme default.
    if port != scheme.default_port() then
      s.append(":")
      s.append(port.string())
    end

    s.append(path)

    match query
      | let q: String =>
        if q.size() > 0 then
          s.append("?")
          s.append(q)
        end
    end

    match fragment
      | let f: String =>
        if f.size() > 0 then
          s.append("#")
          s.append(f)
        end
    end

    consume s


primitive HTTP
  fun default_port(): Port => 80
  fun string(): String iso^ => "http".string()

primitive HTTPS
  fun default_port(): Port => 443
  fun string(): String iso^ => "https".string()

type Scheme is (HTTP | HTTPS)
type Host is String
type Port is U16
type Path is String
type Query is String
type Fragment is String

primitive UriRegex
  fun uri(): Regex? =>
    Regex(
      // Parses the scheme
      "^(?:([a-zA-Z][a-zA-Z0-9+.-]*):)?" +
      // Parses the host and port
      "(?://([^\\/?#]*))?" +
      // Parses the path
      "([^?#]*)" +
      // Parses the query
      "(?:\\?([^#]*))?" +
      // Parses the fragment
      "(?:#(.*))?$"
    )?
