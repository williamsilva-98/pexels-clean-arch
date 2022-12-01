abstract class IHttpClient {
  Future<HttpResponse> get(String url, {Map<String, String>? headers});
}

class HttpResponse {
  final dynamic data;
  final int? statusCode;

  HttpResponse(this.data, this.statusCode);
}
