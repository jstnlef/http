use "promises"

class Session
  """
  Holds a reference to a persistent connection to the server.
  """
  new create() =>
    None

  fun dispose() =>
    None

  fun request(req: Request): Promise[Response] =>
    let p = Promise[Response]
    p(Response(OK))
    p
