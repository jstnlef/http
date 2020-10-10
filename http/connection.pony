use "collections"
use "net"
use "promises"

actor _Connection
  let _auth: TCPConnectionAuth
  let _connection_id: _ConnectionId
  var _tcp_conn: (None | _Connecting | TCPConnection) = None
  var _pending: List[_RequestWithPromise] = List[_RequestWithPromise]
  var _awaiting_response: List[_RequestWithPromise] = List[_RequestWithPromise]

  new create(auth: TCPConnectionAuth, conn_id: _ConnectionId) =>
    _auth = auth
    _connection_id = conn_id

  be send_req(req: Request val, promise: Promise[Response]) =>
    _pending.push(_RequestWithPromise(consume req, promise))
    _send_pending()

  be connected(conn: TCPConnection) =>
    _tcp_conn = conn
    _send_pending()

  be connect_failed(conn: TCPConnection) =>
    _tcp_conn = None

  fun ref _send_pending() =>
    try
      let conn = _tcp_conn as TCPConnection
      try
        let pending = _pending.shift()?
        // TODO: Maybe this needs to be done peicemeal rather that serializing the whole thing.
        conn.writev(pending.req.serialize())
        _awaiting_response.push(consume pending)
      end
    else
      _connect_to_server()
    end

  fun ref _connect_to_server() =>
    match _tcp_conn
      | let _: None =>
        TCPConnection(
          _auth,
          _HTTPConnectionNotify(this),
          _connection_id.host,
          _connection_id.port.string()
        )
        _tcp_conn = _Connecting
    end


primitive _Connecting


class _RequestWithPromise
  let req: Request val
  let resp: Promise[Response]

  new create(req': Request val, resp': Promise[Response]) =>
    req = req'
    resp = resp'


class val _ConnectionId is (Hashable & Equatable[_ConnectionId])
  let scheme: String
  let host: String
  let port: U16

  new val create(url: Url) =>
    scheme = url.scheme.string()
    host = url.host
    port = url.port

  fun hash(): USize =>
    scheme.hash() xor host.hash() xor port.hash()

  fun eq(that: _ConnectionId box): Bool =>
    (scheme == that.scheme)
      and (host == that.host)
      and (port == that.port)
