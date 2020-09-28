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
    try
      let url = Url("http://www.test.com")?
      env.out.print(url.scheme.string())
      env.out.print(url.host.string())
      env.out.print(url.port.string())
      env.out.print(url.path.string())
      env.out.print(url.query.string())
      env.out.print(url.fragment.string())
      env.out.print(url.string())
    end
    // try
    //   TCPConnection(env.root as AmbientAuth,
    //     recover MyTCPConnectionNotify(env.out) end, "", "5000")
    // end
