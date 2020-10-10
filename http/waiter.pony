use "promises"

class ResponseWaiter
  let _promise: Promise[Response]
  var _resp: (Response | None) = None

  new create(promise': Promise[Response]) =>
    _promise = promise'
    _promise.next[None]({ (r) =>
      _resp = r
    })

  fun ref wait(): Response =>
    while _resp is None do
      None
    end

    match _resp
      | let r: Response => r
      | None => Response(OK)
    end
