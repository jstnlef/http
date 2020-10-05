"""
Example of fetching a request.
"""

use "net"
use "../http"

actor Main
  new create(env: Env) =>
    let url = "http://localhost:5000"

    try
      let client = HttpClient(env.root as AmbientAuth)
      client.get(url)
        .next[None](
          {
            (r) => env.out.print(r.body)
          },
          {
            () => env.err.print("Unable to make request!")
          }
        )
    end
