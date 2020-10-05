use "buffered"
use "promises"
use "net"

class _HTTPConnectionNotify is TCPConnectionNotify
  let _responsePromise: Promise[Response]
  let _buffer: Reader = Reader

  new iso create(
    responsePromise: Promise[Response]
  ) =>
    _responsePromise = responsePromise

  fun ref connected(conn: TCPConnection ref) =>
    conn.write("GET / HTTP/1.1\r\n\r\n")

  fun ref received(
    conn: TCPConnection ref,
    data: Array[U8] iso,
    times: USize
  ): Bool =>
    _buffer.append(consume data)
    _responsePromise(Response(OK))
    true

  fun ref connect_failed(conn: TCPConnection ref) =>
    None

  fun ref closed(conn: TCPConnection ref) =>
    _buffer.clear()
