use "net"
use "../http"

actor Main
  new create(env: Env) =>
    let url = "http://localhost:5000"

    try
      let client = HttpClient(env.root as AmbientAuth)
      let futureResp = client.get(url)?
      futureResp.next[None]({ (r) =>
        env.out.print(r.string())
      })

      // TCPConnection(
      //   env.root as AmbientAuth,
      //   recover MyTCPConnectionNotify(env.out) end,
      //   "",
      //   "5000"
      // )
    end


// class PrintFulfill is Fulfill[String, String]
//   let _env: Env
//   let _msg: String
//   new create(env: Env, msg: String) =>
//     _env = env
//     _msg = msg
//   fun apply(s: String): String =>
//     _env.out.print(" + ".join([s; _msg].values()))
//     s

// actor Main
//   new create(env: Env) =>
//      let promise = Promise[String]
//      promise.next[String]({(s: String): String =>
//       env.out.print("foo")
//       ""
//      })
//      promise.next[String](recover PrintFulfill(env, "bar") end)
//      promise.next[String](recover PrintFulfill(env, "baz") end)
//      promise("fulfilled")
