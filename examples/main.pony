"""
Example of fetching a request.
"""

use "net"
use "../http"
use "promises"

actor Main
  new create(env: Env) =>
    try
      let client = HttpClient(env.root as AmbientAuth)
      let url = Url("http://localhost:5000")?
      client.get(url).next[None]({ (resp) =>
        env.out.print(resp.protocol)
        env.out.print(resp.status.string())
        env.out.print("Headers")
        for (header, value) in resp.headers.pairs() do
          env.out.print(header + ": " + value)
        end
        env.out.print("Body")
        env.out.print(resp.body)
      })
    end
