use "collections"
use "net"
use "promises"

class Session
  let _auth: TCPConnectionAuth
  let _connections: Map[_ConnectionId, _Connection] = Map[_ConnectionId, _Connection]

  new create(auth: TCPConnectionAuth) =>
    _auth = auth

  fun ref dispose() =>
    _connections.clear()

  fun request(req: Request val): Promise[Response] =>
    // TODO: This needs to fetch from the connections if a connection to a particular
    // connection identifier already exists.
    let conn_id = _ConnectionId(req.url)
    let conn = _Connection(_auth, conn_id)
    let response = Promise[Response]
    conn.send_req(consume req, response)
    response
