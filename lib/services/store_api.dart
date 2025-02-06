import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._();

  static ApiHelper apiHelper = ApiHelper._();
  final String api = "https://api.imgur.com/3/image";
  String clientID = 'e9fe7336bfdaa03';
  String clientSecret = '314f85d201e61fa7794397964f45b0d35d513f50';

  Future<String?> imageUpload({required Uint8List image}) async {
    Uri url = Uri.parse(api);
    final helper = {
      'Authorization': 'Client-ID ${clientID}'
    };
    final body = base64Encode(image);
    http.Response response = await http.post(
      url,
      headers: helper,
      body: body,
    );

    if (response.statusCode == 200) {
      final data = response.body;
      final json = jsonDecode(data);
      final link = json['data']['link'];
      return link;
    }
    return null;
  }
}
