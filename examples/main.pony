use "net"
use "../http"

class MyTCPConnectionNotify is TCPConnectionNotify
  let _out: OutStream

  new create(out: OutStream) =>
    _out = out

  fun ref connected(conn: TCPConnection ref) =>
    conn.write("GET / HTTP/1.1\r\n\r\n")

  fun ref received(
    conn: TCPConnection ref,
    data: Array[U8] iso,
    times: USize
  ): Bool =>
    _out.print(String.from_array(consume data))
    conn.close()
    true

  fun ref connect_failed(conn: TCPConnection ref) =>
    None

actor Main
  new create(env: Env) =>
    // let b = match Continue
    //   | Stringable => true
    //   else
    //     false
    //   end

    // env.out.print(b)
    try
      TCPConnection(env.root as AmbientAuth,
        recover MyTCPConnectionNotify(env.out) end, "", "5000")
    end
