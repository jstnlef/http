class val Response
  let _status: Status

  new val create(status: Status) =>
    _status = status

  fun string(): String iso^ =>
    ("Response(" + _status.code().string() + ")").string()
