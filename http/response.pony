class Response
  var protocol: String = ""
  var status: Status = BadRequest
  var body: ByteSeq = ""

  fun ref _add_header(key: String, value: String) =>
    // TODO: Need to store and add the headers here.
    None

  fun ref _set_body(body': ByteSeq) =>
    body = body'

  fun string(): String iso^ =>
    ("Response(" + status.code().string() + ")").string()
