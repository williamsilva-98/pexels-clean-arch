import 'package:pexels_clean_arch/core/http/ihttp_client.dart';
import 'package:http/http.dart' as http;

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future<HttpResponse> get(String url, {Map<String, String>? headers}) async {
    final response = await client.get(
      Uri.parse(url),
      headers: headers,
    );
    return HttpResponse(response.body, response.statusCode);
  }
}
