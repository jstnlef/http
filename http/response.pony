use "collections"


class Response
  var protocol: String = ""
  var status: Status = BadRequest
  var body: ByteSeq = ""
  var headers: Map[String, String] iso = recover iso Map[String, String] end

  fun ref _add_header(header: String, value: String): (String^ | None) =>
    headers.update(header, value)

  fun ref _set_body(body': ByteSeq) =>
    body = body'

  fun string(): String iso^ =>
    ("Response(" + status.code().string() + ")").string()
