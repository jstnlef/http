use "net"

class HTTPClient
  let _auth: TCPConnectionAuth

  new create(auth: TCPConnectionAuth) =>
    _auth = auth

  fun request(method: Method, url: Url): Response =>
    Response(OK)

  fun get(url: String): Response? =>
    request(GET, Url(url)?)

  fun head(url: String): Response? =>
    request(HEAD, Url(url)?)

  fun post(url: String): Response? =>
    request(POST, Url(url)?)

  fun put(url: String): Response? =>
    request(PUT, Url(url)?)

  fun delete(url: String): Response? =>
    request(DELETE, Url(url)?)

  fun connect(url: String): Response? =>
    request(CONNECT, Url(url)?)

  fun options(url: String): Response? =>
    request(OPTIONS, Url(url)?)

  fun trace(url: String): Response? =>
    request(TRACE, Url(url)?)

  fun patch(url: String): Response? =>
    request(PATCH, Url(url)?)
