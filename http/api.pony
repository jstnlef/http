primitive Http
  fun request(method: Method, url: Url): String =>
    "url"

  fun get(url: String): String =>
    request(GET, Url(url))

  fun head(url: String): String =>
    request(HEAD, Url(url))

  fun post(url: String): String =>
    request(POST, Url(url))

  fun put(url: String): String =>
    request(PUT, Url(url))

  fun delete(url: String): String =>
    request(DELETE, Url(url))

  fun connect(url: String): String =>
    request(CONNECT, Url(url))

  fun options(url: String): String =>
    request(OPTIONS, Url(url))

  fun trace(url: String): String =>
    request(TRACE, Url(url))

  fun patch(url: String): String =>
    request(PATCH, Url(url))
