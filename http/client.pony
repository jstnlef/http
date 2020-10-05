use "net"
use "promises"

class HttpClient
  let _auth: TCPConnectionAuth

  new create(auth: TCPConnectionAuth) =>
    _auth = auth

  fun request(
    method: Method,
    url: String
  ): Promise[Response] =>
    // TODO: This might be a compiler bug. I shouldn't neet to instantiate this here.
    // A var ret: Promise[Response] should do just fine but it doesn't...
    var ret = Promise[Response]
    with session = Session(_auth) do
      ret = session.request(method, url)
    end
    ret

  fun get(url: String): Promise[Response] =>
    request(GET, url)

  fun head(url: String): Promise[Response] =>
    request(HEAD, url)

  fun post(url: String): Promise[Response] =>
    request(POST, url)

  fun put(url: String): Promise[Response] =>
    request(PUT, url)

  fun delete(url: String): Promise[Response] =>
    request(DELETE, url)

  fun connect(url: String): Promise[Response] =>
    request(CONNECT, url)

  fun options(url: String): Promise[Response] =>
    request(OPTIONS, url)

  fun trace(url: String): Promise[Response] =>
    request(TRACE, url)

  fun patch(url: String): Promise[Response] =>
    request(PATCH, url)
