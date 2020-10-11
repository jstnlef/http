use "net"
use "promises"

class HttpClient
  let _auth: TCPConnectionAuth

  new create(auth: TCPConnectionAuth) =>
    _auth = auth

  fun session(): Session =>
    Session(_auth)

  fun request(req: Request val): Promise[Response val] =>
    // // TODO: This might be a compiler bug. I shouldn't neet to instantiate this here.
    // // A var ret: Promise[Response] should do just fine but it doesn't...
    var ret = Promise[Response val]
    with s = session() do
      ret = s.request(consume req)
    end
    ret

  fun get(url: String): Promise[Response val]? =>
    let u = Url(url)?
    request(Request(GET, u))

  // fun head(url: String): Promise[Response] =>
  //   request(HEAD, url)

  // fun post(url: String): Promise[Response] =>
  //   request(POST, url)

  // fun put(url: String): Promise[Response] =>
  //   request(PUT, url)

  // fun delete(url: String): Promise[Response] =>
  //   request(DELETE, url)

  // fun connect(url: String): Promise[Response] =>
  //   request(CONNECT, url)

  // fun options(url: String): Promise[Response] =>
  //   request(OPTIONS, url)

  // fun trace(url: String): Promise[Response] =>
  //   request(TRACE, url)

  // fun patch(url: String): Promise[Response] =>
  //   request(PATCH, url)
