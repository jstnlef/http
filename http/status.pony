trait val Status
  fun apply(): U16
  fun string(): String

primitive Continue is Status
  fun apply(): U16 => 100
  fun string(): String => "100 Continue"
primitive SwitchingProtocols is Status
  fun apply(): U16 => 101
  fun string(): String => "101 Switching Protocols"

primitive OK is Status
  fun apply(): U16 => 200
  fun string(): String => "200 OK"
primitive Created is Status
  fun apply(): U16 => 201
  fun string(): String => "201 Created"
primitive Accepted is Status
  fun apply(): U16 => 202
  fun string(): String => "202 Accepted"
primitive NonAuthoritativeInfo is Status
  fun apply(): U16 => 203
  fun string(): String => "203 Non-Authoritative Information"
primitive NoContent is Status
  fun apply(): U16 => 204
  fun string(): String => "204 No Content"
primitive ResetContent is Status
  fun apply(): U16 => 205
  fun string(): String => "205 Reset Content"
primitive PartialContent is Status
  fun apply(): U16 => 206
  fun string(): String => "206 Partial Content"

primitive MultipleChoices is Status
  fun apply(): U16 => 300
  fun string(): String => "300 Multiple Choices"
primitive MovedPermanently is Status
  fun apply(): U16 => 301
  fun string(): String => "301 Moved Permanently"
primitive Found is Status
  fun apply(): U16 => 302
  fun string(): String => "302 Found"
primitive SeeOther is Status
  fun apply(): U16 => 303
  fun string(): String => "303 See Other"
primitive NotModified is Status
  fun apply(): U16 => 304
  fun string(): String => "304 Not Modified"
primitive UseProxy is Status
  fun apply(): U16 => 305
  fun string(): String => "305 Use Proxy"
primitive TemporaryRedirect is Status
  fun apply(): U16 => 307
  fun string(): String => "307 Temporary Redirect"

primitive BadRequest is Status
  fun apply(): U16 => 400
  fun string(): String => "400 Bad Request"
primitive Unauthorized is Status
  fun apply(): U16 => 401
  fun string(): String => "401 Unauthorized"
primitive PaymentRequired is Status
  fun apply(): U16 => 402
  fun string(): String => "402 Payment Required"
primitive Forbidden is Status
  fun apply(): U16 => 403
  fun string(): String => "403 Forbidden"
primitive NotFound is Status
  fun apply(): U16 => 404
  fun string(): String => "404 Not Found"
primitive MethodNotAllowed is Status
  fun apply(): U16 => 405
  fun string(): String => "405 Method Not Allowed"
primitive NotAcceptable is Status
  fun apply(): U16 => 406
  fun string(): String => "406 Not Acceptable"
primitive ProxyAuthRequired is Status
  fun apply(): U16 => 407
  fun string(): String => "407 Proxy Authentication Required"
primitive RequestTimeout is Status
  fun apply(): U16 => 408
  fun string(): String => "408 Request Timeout"
primitive Conflict is Status
  fun apply(): U16 => 409
  fun string(): String => "409 Conflict"
primitive Gone is Status
  fun apply(): U16 => 410
  fun string(): String => "410 Gone"
primitive LengthRequired is Status
  fun apply(): U16 => 411
  fun string(): String => "411 Length Required"
primitive PreconditionFailed is Status
  fun apply(): U16 => 412
  fun string(): String => "412 Precondition Failed"
primitive RequestEntityTooLarge is Status
  fun apply(): U16 => 413
  fun string(): String => "413 Request Entity Too Large"
primitive RequestURITooLong is Status
  fun apply(): U16 => 414
  fun string(): String => "414 Request URI Too Long"
primitive UnsupportedMediaType is Status
  fun apply(): U16 => 415
  fun string(): String => "415 Unsupported Media Type"
primitive RequestedRangeNotSatisfiable is Status
  fun apply(): U16 => 416
  fun string(): String => "416 Requested Range Not Satisfiable"
primitive ExpectationFailed is Status
  fun apply(): U16 => 417
  fun string(): String => "417 Expectation Failed"
primitive Teapot is Status
  fun apply(): U16 => 418
  fun string(): String => "418 I'm a teapot"
primitive PreconditionRequired is Status
  fun apply(): U16 => 428
  fun string(): String => "428 Precondition Required"
primitive TooManyRequests is Status
  fun apply(): U16 => 429
  fun string(): String => "429 Too Many Requests"
primitive RequestHeaderFieldsTooLarge is Status
  fun apply(): U16 => 431
  fun string(): String => "431 Request Header Fields Too Large"
primitive UnavailableForLegalReasons is Status
  fun apply(): U16 => 451
  fun string(): String => "451 Unavailable For Legal Reasons"

primitive InternalServerError is Status
  fun apply(): U16 => 500
  fun string(): String => "500 Internal Server Error"
primitive NotImplemented is Status
  fun apply(): U16 => 501
  fun string(): String => "501 Not Implemented"
primitive BadGateway is Status
  fun apply(): U16 => 502
  fun string(): String => "502 Bad Gateway"
primitive ServiceUnavailable is Status
  fun apply(): U16 => 503
  fun string(): String => "503 Service Unavailable"
primitive GatewayTimeout is Status
  fun apply(): U16 => 504
  fun string(): String => "504 Gateway Timeout"
primitive HTTPVersionNotSupported is Status
  fun apply(): U16 => 505
  fun string(): String => "505 HTTP Version Not Supported"
primitive NetworkAuthenticationRequired is Status
  fun apply(): U16 => 511
  fun string(): String => "511 Network Authentication Required"
