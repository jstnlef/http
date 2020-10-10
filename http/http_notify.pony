use "buffered"
use "net"

class _HTTPConnectionNotify is TCPConnectionNotify
  let _conn: _Connection
  let _buffer: Reader = Reader
  let _parser: Parser = Parser

  new iso create(conn: _Connection) =>
    _conn = conn

  fun ref connected(conn: TCPConnection ref) =>
    _conn.connected(conn)

  fun ref received(
    conn: TCPConnection ref,
    data: Array[U8] iso,
    times: USize
  ): Bool =>
    _buffer.append(consume data)
    true

  fun ref connect_failed(conn: TCPConnection ref) =>
    _conn.connect_failed(conn)

  fun ref closed(conn: TCPConnection ref) =>
    _buffer.clear()
