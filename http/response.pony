class Response
  var proto: String = ""
  var status: Status = BadRequest
  var body: ByteSeq = ""

  fun string(): String iso^ =>
    ("Response(" + status.code().string() + ")").string()
