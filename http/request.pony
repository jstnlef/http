use "buffered"
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

  fun serialize(): Array[ByteSeq] val =>
    // TODO: This needs to be cleverer
    let writer = Writer
    writer.write("GET / HTTP/1.1\r\n\r\n")
    writer.done()


type Headers is (Map[String, String] | None)
