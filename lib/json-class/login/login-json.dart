import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:kmkshoppinglist/json-class/login/login-model-json.dart';
import 'package:kmkshoppinglist/json-class/variable-json.dart';

class LoginJson {
/*
  _loginToJson(LoginSubmitJson data) {

    final dyn = data.toJson();

    return json.encode(dyn);

  }

  LoginReceivedJson loginFromJson(String str) {

    final jsonData = json.decode(str);

    return LoginReceivedJson.fromJson(jsonData);
  }

  Future<String> getToken(LoginSubmitJson data) async{

    final response = await http.post(url('Login'),
      body: _loginToJson(data)
    );

    if(response.statusCode > 200)
      return _loginFromJson(response.body).acessToken;

    return null;
  }*/

  static Future<LoginModelJson> getLoginJson(LoginModelJson data) async{

    final dyn = data.toJson();

    final j = json.encode(dyn);

    dynamic response;

    try {
      response = await http.post(url('Login', 1),
        headers: {
          HttpHeaders.contentTypeHeader: contentType()
        },
        body: j
      );
    } catch(Exeception){
      response = await http.post(url('Login', 2),
        headers: {
          HttpHeaders.contentTypeHeader: contentType()
        },
        body: j
      );
    }

    if(response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        return LoginModelJson.fromJson(jsonData);
    } else {
      statusJson = 404;
      throw Exception('Failed to load post');
    }

    return null;
  }

  static Future<String> getToken(LoginModelJson data) async{

    final dyn = data.toJson();

    final j = json.encode(dyn);

    dynamic response;

    try {
      response = await http.post(url('Login', 1),
        headers: {
          HttpHeaders.contentTypeHeader: contentType()
        },
        body: j
      );
    } catch(Exeception){
      response = await http.post(url('Login', 2),
        headers: {
          HttpHeaders.contentTypeHeader: contentType()
        },
        body: j
      );
    }

    if(response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        return LoginModelJson.fromJson(jsonData).acessToken;
    } else {
      statusJson = 404;
      throw Exception('Failed to load post');
    }
    
    return null;
  }
}

Future<LoginModelJson> fetchPostLogin(LoginModelJson data) async {
  
    final dyn = data.toJson();

    final j = json.encode(dyn);
    
    dynamic response;

    try {
        response = await http.post(url('Login', 1),
          headers: {
            HttpHeaders.contentTypeHeader: contentType()
          },
          body: j
        );
      } catch(Exeception) {
          response = await http.post(url('Login', 2),
            headers: {
              HttpHeaders.contentTypeHeader: contentType()
            },
            body: j
          );
      }

    if (response.statusCode == 200 || response != null) {
      //If the call to the server was successful, parse the JSON.
      return postFromJson(response.body);
    } else {
      // If that call was not successful, throw an error.
      statusJson = 404;
      throw Exception('Failed to load post');
    }
}

