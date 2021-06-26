import 'dart:convert';

import 'package:http/http.dart' as http;

class NetWork {
  // Future<List<Photo>> fetchPhotos(http.Client client) async {
  //   final response = await client
  //       .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  //   return compute(parsePhotos, response.body);
  // }
  //
  // List<Photo> parsePhotos(String responseBody) {
  //   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  //
  //   return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
  // }

  Future getChobi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    if (response.statusCode == 200) {

      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    }
  }
}
