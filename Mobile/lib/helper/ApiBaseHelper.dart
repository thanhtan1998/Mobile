import 'dart:io';
import 'package:eaw/helper/HandleException.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  Future<dynamic> get(
      String url, String httpMethod, Map<String, String> headers,
      [String body]) async {
    var responseJson, response;
    try {
      switch (httpMethod) {
        case 'get':
          response = await http.get(url, headers: headers);
          break;
        case 'put':
          response = await http.put(url, headers: headers);
          break;
        case 'delete':
          response = await http.delete(url, headers: headers);
          break;
        case 'post':
          response = await http.post(url, headers: headers, body: body);
          break;
        case 'patch':
          response = await http.patch(url, headers: headers, body: body);
          break;
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('Không thể kết nối đến máy chủ');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
        break;
      case 400:
        throw BadRequestException();
        break;
      case 401:
        break;
      case 403:
        throw UnauthorisedException();
        break;
      case 404:
        throw NotFoundException();
        break;
      case 500:
        break;
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
