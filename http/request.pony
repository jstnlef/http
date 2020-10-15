use "buffered"
use "collections"


class val Request
  let method: Method
  let url: Url
  let body: ByteSeq
  let headers: Map[String, String] iso

  new val create(
    method': Method,
    url': Url,
    body': ByteSeq = "",
    headers': Map[String, String] iso = recover iso Map[String, String] end
  ) =>
    method = method'
    url = url'
    body = body'
    headers = consume headers'

  fun ref add_header(header: String, value: String): (String^ | None) =>
    headers.update(header, value)

  fun serialize(): Array[ByteSeq] val =>
    // TODO: This needs to be cleverer
    let writer = Writer
    writer.write("GET / HTTP/1.1\r\n\r\n")
    writer.done()
