use "collections"
use "net"
use "promises"

actor _Connection
  let _auth: TCPConnectionAuth
  var _tcp_conn: (TCPConnection | None) = None
  var _pending_requests: Array[Request] = Array[Request](4)
  var _pending_responses: Array[Promise[Response]] = Array[Promise[Response]](4)
  // TODO: Maybe split this into a pending requests and response maps by id.

  new create(auth: TCPConnectionAuth, host: String, port: U16) =>
    _auth = auth
    TCPConnection(
      _auth,
      _HTTPConnectionNotify(this),
      host,
      port.string()
    )

  be push_req(req: Request val, promise: Promise[Response]) =>
    _pending_requests.push(consume req)
    _pending_responses.push(promise)

  be connected(conn: TCPConnection) =>
    _tcp_conn = conn
    _send_pending()

  fun ref _send_pending() =>
    try
      let conn = _tcp_conn as TCPConnection
      conn.write("GET / HTTP/1.1\r\n\r\n")
    end
