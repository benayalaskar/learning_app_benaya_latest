import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learning_app_benaya_latest/data/response/login_response/login_response.dart';

class ApiRepository {
  Future<LoginResponse> authenticate(String identifier, String password) async {
    //penambahan future function untuk membaut post request untuk autentikasi API di http://10.0.2.2:1337/api/auth/local

    final response = await http.post(
      Uri.parse("http://10.0.2.2:1337/api/auth/local"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'identifier': identifier,
          'password': password,
        },
      ),
    );
    print(response.body);
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.body);
    } else {
      throw Exception("Failed To Authenticate");
    }
  }
}
