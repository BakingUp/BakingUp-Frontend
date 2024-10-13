import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkService {
  late final Dio _dio;
  static final NetworkService _instance = NetworkService.internal();

  NetworkService.internal();

  static NetworkService get instance => _instance;

  Future<void> initClient() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL']!,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(url, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      final data = Map<String, dynamic>.from(e.response?.data);
      throw Exception(data['message'] ?? "Error while fetching data");
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.post(url, data: data);
      return response.data;
    } on DioException catch (e) {
      log(e.toString());
      final responseData = e.response?.data;
      if (responseData != null && responseData is Map<String, dynamic>) {
        throw Exception(responseData['message'] ?? "Error while posting data");
      } else {
        throw Exception("Error while posting data");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.delete(url, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      final data = Map<String, dynamic>.from(e.response?.data);
      throw Exception(data['message'] ?? "Error while deleting data");
    } catch (e) {
      rethrow;
    }
  }
}
