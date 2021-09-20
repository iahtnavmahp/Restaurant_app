import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restauant_app/src/utils/base/base_import.dart';

class BaseNetwork {
  SharedPreferences sharedPreferences;

  Future<dynamic> networkService({
    String paramUrl,
    FunctionType functionType,
    Map<String, dynamic> body,
    Function success(object),
    Function error(err),
  }) async {
    sharedPreferences = await SharedPreferences.getInstance();
    String url = Uri.encodeFull(paramUrl);

    Map<String, String> header;
    if (header == null) header = {};
    var contentBody;

    if (header.containsKey('Content-Type') && header["Content-Type"].toLowerCase().contains("x-www-form-urlencoded"))
      contentBody = body.keys.map((key) => "$key=${body[key]}").join("&");
    else
      contentBody = jsonEncode(body);

    if (functionType == FunctionType.POST || functionType == FunctionType.PUT_BODY) {
      if (!header.containsKey('Content-Type'))
        header.addAll({
          "Content-Type": "application/json",
        });
    }

    if (!header.containsKey('authorization') && sharedPreferences.getString(Constant.KEY_ACCESSTOKEN) != null)
      header.addAll({
        HttpHeaders.authorizationHeader: "Bearer " + sharedPreferences.getString(Constant.KEY_ACCESSTOKEN),
      });

    http.Response param;

    if (functionType == FunctionType.POST) {
      param = await http.post(url, body: contentBody, headers: header);
    } else if (functionType == FunctionType.DELETE) {
      param = await http.delete(url, headers: header);
    } else  if (functionType == FunctionType.PUT){
      param = await http.put(url, headers: header);
    }else  if (functionType == FunctionType.PUT_BODY){
      param = await http.put(url, headers: header,body: contentBody);
    }else {
      param = await http.get(url, headers: header);
    }

    print("URL: " + paramUrl);
    print("Headers: $header");
    print("FunctionType: $functionType");
    print("Body: " + body.toString());
    var res;
    if (param.statusCode == 200 || param.statusCode <= 300) {
      try {
        res = param.body.trim().isEmpty ? '' : jsonDecode(utf8.decode(param.bodyBytes));
      } catch (e) {
        print(utf8.decode(param.bodyBytes));
        res = '';
      }

      return success(res == null || res.toString().isEmpty ? "" : res);
    } else {
      print("Error: " + utf8.decode(param.bodyBytes));
      return error(utf8.decode(param.bodyBytes));
    }
  }
}

enum FunctionType { POST, GET, DELETE, PUT, PUT_BODY }
