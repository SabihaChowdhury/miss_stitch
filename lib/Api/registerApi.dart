import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  // final String _url = 'https://www.dynamyk.biz/';
  // final String _url = 'http://192.168.0.106:8000';
   //final String _url = 'https://tailor-pro-app.herokuapp.com';
  final String _url = 'http://10.0.2.2:8000';

//   void getHttp() async {
//   try {
//     Response response = await Dio().get("https://mobile.bxxx.com");
//     print(response);
//   } catch (e) {
//     print(e);
//   }
// }

  postData(data, apiUrl) async {
    Uri fullUrl = Uri.parse(_url + apiUrl);
    print(fullUrl);
    return await http.post(fullUrl,
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    Uri fullUrl = Uri.parse(_url + apiUrl + await _getToken());
    print(fullUrl);
    return await http.get(fullUrl, headers: await _setHeaders());
  }

  getData1(apiUrl) async {
    Uri fullUrl = Uri.parse(_url + apiUrl + await _getToken1());
    print(fullUrl);
    return await http.get(fullUrl, headers: await _setHeaders());
  }

  putData(data, apiUrl) async {
    Uri fullUrl = Uri.parse(_url + apiUrl + await _getToken());
    //print(await _setHeaders());
    return await http.put(fullUrl,
        body: jsonEncode(data), headers: await _setHeaders());
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    return '?token=$token';
  }

  _getToken1() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    return '&token=$token';
  }
}
