"""
Example of fetching a request.
"""

use "net"
use "../http"
use "promises"

actor Main
  new create(env: Env) =>
    let url = "http://localhost:5000"

    try
      let client = HttpClient(env.root as AmbientAuth)
      client.get(url)?.next[None]({(resp) =>
        env.out.print(resp.body)
      })
    end
