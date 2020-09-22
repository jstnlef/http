use "regex"

class val Url
  var scheme: Scheme = None
  var path: Path = None
  var port: Port = None
  var query: Query = None
  var fragment: Fragment = None

  new val create(url: String) =>
    try
      scheme = UrlRegex.scheme_re()?(url)?(0)?
    end

  fun string(): String iso^ =>
    "".string()


type Scheme is (String | None)
type Path is (String | None)
type Port is (U16 | None)
type Query is (String | None)
type Fragment is (String | None)

primitive UrlRegex
  fun scheme_re(): Regex? =>
    Regex("^(?:[a-zA-Z][a-zA-Z0-9+-]*:|/)")?
