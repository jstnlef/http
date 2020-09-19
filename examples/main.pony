use "../http"

actor Main
  new create(env: Env) =>
    let resp = Http.get("https://api.github.com/events")
    env.out.print(resp)
