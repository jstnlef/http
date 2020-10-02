use "net"
use "promises"

class HttpClient
  let _auth: TCPConnectionAuth

  new create(auth: TCPConnectionAuth) =>
    _auth = auth

  fun request(req: Request): Promise[Response] =>
    // TODO: This might be a compiler bug. I shouldn't neet to instantiate this here.
    // A var ret: Promise[Response] should do just fine but it doesn't...
    var ret = Promise[Response]
    with session = Session do
      ret = session.request(req)
    end
    ret

  fun get(url: String): Promise[Response]? =>
    let req = Request(
      GET,
      Url(url)?
    )
    request(req)

  fun head(url: String): Promise[Response]? =>
    let req = Request(
      HEAD,
      Url(url)?
    )
    request(req)

  fun post(url: String): Promise[Response]? =>
    let req = Request(
      POST,
      Url(url)?
    )
    request(req)

  fun put(url: String): Promise[Response]? =>
    let req = Request(
      PUT,
      Url(url)?
    )
    request(req)

  fun delete(url: String): Promise[Response]? =>
    let req = Request(
      DELETE,
      Url(url)?
    )
    request(req)

  fun connect(url: String): Promise[Response]? =>
    let req = Request(
      CONNECT,
      Url(url)?
    )
    request(req)

  fun options(url: String): Promise[Response]? =>
    let req = Request(
      OPTIONS,
      Url(url)?
    )
    request(req)

  fun trace(url: String): Promise[Response]? =>
    let req = Request(
      TRACE,
      Url(url)?
    )
    request(req)

  fun patch(url: String): Promise[Response]? =>
    let req = Request(
      PATCH,
      Url(url)?
    )
    request(req)
