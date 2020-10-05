class val Response
  let status: Status
  let body: ByteSeq

  new val create(
    status': Status,
    body': ByteSeq = ""
  ) =>
    status = status'
    body = body'

  fun string(): String iso^ =>
    ("Response(" + status.code().string() + ")").string()
