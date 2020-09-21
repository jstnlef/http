trait val Status is Stringable
  fun code(): U16

primitive Continue is Status
  fun code(): U16 => 100
  fun string(): String iso^ => "100 Continue".string()
primitive SwitchingProtocols is Status
  fun code(): U16 => 101
  fun string(): String iso^ => "101 Switching Protocols".string()
primitive Processing is Status
  fun code(): U16 => 102
  fun string(): String iso^ => "102 Processing".string()

primitive OK is Status
  fun code(): U16 => 200
  fun string(): String iso^ => "200 OK".string()
primitive Created is Status
  fun code(): U16 => 201
  fun string(): String iso^ => "201 Created".string()
primitive Accepted is Status
  fun code(): U16 => 202
  fun string(): String iso^ => "202 Accepted".string()
primitive NonAuthoritativeInfo is Status
  fun code(): U16 => 203
  fun string(): String iso^ => "203 Non-Authoritative Information".string()
primitive NoContent is Status
  fun code(): U16 => 204
  fun string(): String iso^ => "204 No Content".string()
primitive ResetContent is Status
  fun code(): U16 => 205
  fun string(): String iso^ => "205 Reset Content".string()
primitive PartialContent is Status
  fun code(): U16 => 206
  fun string(): String iso^ => "206 Partial Content".string()
primitive MultiStatus is Status
  fun code(): U16 => 207
  fun string(): String iso^ => "207 Multi-Status".string()
primitive AlreadyReported is Status
  fun code(): U16 => 208
  fun string(): String iso^ => "208 Already Reported".string()
primitive IMUsed is Status
  fun code(): U16 => 226
  fun string(): String iso^ => "226 IM Used".string()

primitive MultipleChoices is Status
  fun code(): U16 => 300
  fun string(): String iso^ => "300 Multiple Choices".string()
primitive MovedPermanently is Status
  fun code(): U16 => 301
  fun string(): String iso^ => "301 Moved Permanently".string()
primitive Found is Status
  fun code(): U16 => 302
  fun string(): String iso^ => "302 Found".string()
primitive SeeOther is Status
  fun code(): U16 => 303
  fun string(): String iso^ => "303 See Other".string()
primitive NotModified is Status
  fun code(): U16 => 304
  fun string(): String iso^ => "304 Not Modified".string()
primitive UseProxy is Status
  fun code(): U16 => 305
  fun string(): String iso^ => "305 Use Proxy".string()
primitive TemporaryRedirect is Status
  fun code(): U16 => 307
  fun string(): String iso^ => "307 Temporary Redirect".string()
primitive PermanentRedirect is Status
  fun code(): U16 => 308
  fun string(): String iso^ => "308 Permanent Redirect".string()

primitive BadRequest is Status
  fun code(): U16 => 400
  fun string(): String iso^ => "400 Bad Request".string()
primitive Unauthorized is Status
  fun code(): U16 => 401
  fun string(): String iso^ => "401 Unauthorized".string()
primitive PaymentRequired is Status
  fun code(): U16 => 402
  fun string(): String iso^ => "402 Payment Required".string()
primitive Forbidden is Status
  fun code(): U16 => 403
  fun string(): String iso^ => "403 Forbidden".string()
primitive NotFound is Status
  fun code(): U16 => 404
  fun string(): String iso^ => "404 Not Found".string()
primitive MethodNotAllowed is Status
  fun code(): U16 => 405
  fun string(): String iso^ => "405 Method Not Allowed".string()
primitive NotAcceptable is Status
  fun code(): U16 => 406
  fun string(): String iso^ => "406 Not Acceptable".string()
primitive ProxyAuthRequired is Status
  fun code(): U16 => 407
  fun string(): String iso^ => "407 Proxy Authentication Required".string()
primitive RequestTimeout is Status
  fun code(): U16 => 408
  fun string(): String iso^ => "408 Request Timeout".string()
primitive Conflict is Status
  fun code(): U16 => 409
  fun string(): String iso^ => "409 Conflict".string()
primitive Gone is Status
  fun code(): U16 => 410
  fun string(): String iso^ => "410 Gone".string()
primitive LengthRequired is Status
  fun code(): U16 => 411
  fun string(): String iso^ => "411 Length Required".string()
primitive PreconditionFailed is Status
  fun code(): U16 => 412
  fun string(): String iso^ => "412 Precondition Failed".string()
primitive RequestEntityTooLarge is Status
  fun code(): U16 => 413
  fun string(): String iso^ => "413 Request Entity Too Large".string()
primitive RequestURITooLong is Status
  fun code(): U16 => 414
  fun string(): String iso^ => "414 Request URI Too Long".string()
primitive UnsupportedMediaType is Status
  fun code(): U16 => 415
  fun string(): String iso^ => "415 Unsupported Media Type".string()
primitive RequestedRangeNotSatisfiable is Status
  fun code(): U16 => 416
  fun string(): String iso^ => "416 Requested Range Not Satisfiable".string()
primitive ExpectationFailed is Status
  fun code(): U16 => 417
  fun string(): String iso^ => "417 Expectation Failed".string()
primitive Teapot is Status
  fun code(): U16 => 418
  fun string(): String iso^ => "418 I'm a teapot".string()
primitive UpgradeRequired is Status
  fun code(): U16 => 426
  fun string(): String iso^ => "426 Upgrade Required".string()
primitive PreconditionRequired is Status
  fun code(): U16 => 428
  fun string(): String iso^ => "428 Precondition Required".string()
primitive TooManyRequests is Status
  fun code(): U16 => 429
  fun string(): String iso^ => "429 Too Many Requests".string()
primitive RequestHeaderFieldsTooLarge is Status
  fun code(): U16 => 431
  fun string(): String iso^ => "431 Request Header Fields Too Large".string()
primitive UnavailableForLegalReasons is Status
  fun code(): U16 => 451
  fun string(): String iso^ => "451 Unavailable For Legal Reasons".string()

primitive InternalServerError is Status
  fun code(): U16 => 500
  fun string(): String iso^ => "500 Internal Server Error".string()
primitive NotImplemented is Status
  fun code(): U16 => 501
  fun string(): String iso^ => "501 Not Implemented".string()
primitive BadGateway is Status
  fun code(): U16 => 502
  fun string(): String iso^ => "502 Bad Gateway".string()
primitive ServiceUnavailable is Status
  fun code(): U16 => 503
  fun string(): String iso^ => "503 Service Unavailable".string()
primitive GatewayTimeout is Status
  fun code(): U16 => 504
  fun string(): String iso^ => "504 Gateway Timeout".string()
primitive HTTPVersionNotSupported is Status
  fun code(): U16 => 505
  fun string(): String iso^ => "505 HTTP Version Not Supported".string()
primitive NetworkAuthenticationRequired is Status
  fun code(): U16 => 511
  fun string(): String iso^ => "511 Network Authentication Required".string()
