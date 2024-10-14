import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

// The ApiService class for making HTTP GET and POST requests
class ApiService {
  // Base URL for the Google Books API
  final _baseUrl = 'https://dummyjson.com';

  String? token;
  // Dio instance used for making HTTP requests
  final Dio _dio;

  // Constructor to initialize the ApiService with a Dio instance
  ApiService(this._dio);

  // Asynchronous function to make a GET request to the API
  Future<Map<String, dynamic>> get({required String endPoint,Map<String, dynamic>? queryParameters }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') == null) {
      prefs.setString('token', '');
    }
    token = prefs.getString('token');

    // Send a GET request to the specified endPoint by combining it with the base URL
    var response = await _dio.get(
      '$_baseUrl$endPoint',
      queryParameters: queryParameters,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      }),
    );
    //  Logger().i(response.toString());
    // Return the response data as a map (dynamic) containing key-value pairs
    return response.data;
  }

  // Asynchronous function to make a POST request to the API
  Future<Map<String, dynamic>> post(
      {required String endPoint, required dynamic data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') == null) {
      prefs.setString('token', '');
    }
    token = prefs.getString('token');

    // Send a POST request to the specified endPoint by combining it with the base URL
    var response = await _dio.post(
      '$_baseUrl$endPoint',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
        // 'Accept': 'application/json',
      }),
    );

    if (kDebugMode) {
      Logger().i(response.toString());
    }

    // Return the response data as a map (dynamic) containing key-value pairs
    return response.data;
  }

  // Asynchronous function to make a DELETE request to the API
  Future<Map<String, dynamic>> delete({required String endPoint}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') == null) {
      prefs.setString('token', '');
    }
    token = prefs.getString('token');

    // Send a DELETE request to the specified endPoint by combining it with the base URL
    var response = await _dio.delete(
      '$_baseUrl$endPoint',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }),
    );

    if (kDebugMode) {
      Logger().i(response.toString());
    }

    // Return the response data as a map (dynamic) containing key-value pairs
    return response.data;
  }

  // Asynchronous function to make an UPDATE request to the API
  Future<Map<String, dynamic>> update(
      {required String endPoint, required dynamic data}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');

    // Send an UPDATE request to the specified endPoint by combining it with the base URL
    var response = await _dio.put(
      '$_baseUrl$endPoint',
      data: data,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      }),
    );

    if (kDebugMode) {
      Logger().i(response.toString());
    }

    // Return the response data as a map (dynamic) containing key-value pairs
    return response.data;
  }
}
