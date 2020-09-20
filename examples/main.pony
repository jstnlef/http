use "net"
use "../http"

actor Main
  new create(env: Env) =>
    try
      let client = Client(env.root as AmbientAuth)
      let resp = client.get("https://api.github.com/events")
      env.out.print(resp.string())
    end
