import 'package:animal_app/network/api_constants.dart';
import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dioMain;
  static late Dio dioWhatsapp;

  static init() {
    dioMain = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveDataWhenStatusError: true,

    ));
    dioWhatsapp = Dio(BaseOptions(
      baseUrl: ApiConstants.whatsAppVerificationBaseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dioMain.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    return await dioMain.get(url, queryParameters: query);
  }

  static Future<Response> getWhatsappAuth({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dioWhatsapp.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    return await dioWhatsapp.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
    String? token,
    ProgressCallback? onSendProgress,
  }) async
  {
    dioMain.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type':'application/json',
      'Accept': 'application/json',
    };
    return dioMain.post(url, queryParameters: query, data: data,onSendProgress: onSendProgress);
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async
  {
    dioMain.options.headers = {
      'Content-Type':'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return dioMain.put(url, queryParameters: query, data: data);
  }
}
