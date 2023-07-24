import 'dart:typed_data';

import 'package:admin_dashboard/services/local_storage.dart';
import 'package:dio/dio.dart';

class BackendApi {
  static final Dio _dio = Dio();

  static void configureDio() {
    // BaseURL
    _dio.options.baseUrl = 'http://localhost:3001/api';

    // Configurar Headers
    _dio.options.headers = {
      'x-token': LocalStorage.preferences?.getString('token') ?? ''
    };
  }

  static Future httpGet(String path) async {
    try {
      Response response = await _dio.get(path);

      return response.data;
    } on DioError catch (e) {
      throw (errorMessage(e) ?? 'Request Error');
    }
  }

  static Future post(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);
    try {
      Response response = await _dio.post(path, data: formData);
      return response.data;
    } on DioError catch (e) {
      throw (errorMessage(e) ?? 'POST Error');
    }
  }

  static Future put(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.put(path, data: formData);
      return resp.data;
    } on DioError catch (e) {
      throw (errorMessage(e) ?? 'Update Error');
    }
  }

  static Future delete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.delete(path, data: formData);
      return resp.data;
    } on DioError catch (e) {
      throw (errorMessage(e) ?? 'Delete Error');
    }
  }

  static Future uploadFile(String path, Uint8List bytes) async {
    final formData =
        FormData.fromMap({'archivo': MultipartFile.fromBytes(bytes)});

    try {
      final resp = await _dio.put(path, data: formData);

      return resp.data;
    } on DioError catch (e) {
      throw (errorMessage(e) ?? 'Update Error');
    }
  }

  static String? errorMessage(DioError e) {
    String? message;
    if (e.response != null &&
        e.response?.data != null &&
        e.response?.data['errors'] != null) {
      List<dynamic> errors = e.response?.data['errors'];

      //get first error
      message = errors[0]['msg'];
    }

    if (e.response?.data['message'] != null) {
      message = e.response?.data['message'];
    }

    return message;
  }
}
