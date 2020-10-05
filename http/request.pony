use "collections"


class val Request
  let method: Method
  let url: Url
  let body: ByteSeq
  // let headers: Headers

  new val create(
    method': Method,
    url': Url,
    body': ByteSeq = ""
    // headers': Headers = None
  ) =>
    method = method'
    url = url'
    body = body'
    // headers = headers'


type Headers is (Map[String, String] | None)
