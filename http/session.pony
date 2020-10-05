use "collections"
use "net"
use "promises"

class Session
  let _auth: TCPConnectionAuth
  let _connections: Map[String, _Connection] = Map[String, _Connection]

  new create(auth: TCPConnectionAuth) =>
    _auth = auth

  fun ref dispose() =>
    _connections.clear()

  fun request(method: Method, url: String): Promise[Response] =>
    try
      let req = Request(
        method,
        Url(url)?
      )

      // TODO: This needs to fetch from the connections if a connection to a particular
      // connection identifier already exists.
      let conn = _Connection(_auth, req.url.host, req.url.port)
      let promise = Promise[Response]
      conn.push_req(req, promise)
      promise
    else
      // Hrmm... I would really like to reject this promise with some value.
      let ret = Promise[Response]
      ret.reject()
      ret
    end

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
