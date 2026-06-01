import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class AppsNetworkService {
  static const tag = 'AppsNetworkService';
  static const _baseUrl = 'http://api.alquran.cloud/v1';
  static const _timeout = Duration(seconds: 30);

  // instance untuk seluruh app, aksesnya via get()
  static final AppsNetworkService _instance = AppsNetworkService._();
  static AppsNetworkService get() => _instance;

  AppsNetworkService._();

  http.Client _newClient() {
    final ioClient = HttpClient()
      ..connectionTimeout = const Duration(seconds: 15);
    return IOClient(ioClient);
  }

  Map<String, String> get _getHeaders => {
    'Accept': 'application/json',
  };

  Future<Map<String, dynamic>> fetch(String endpoint, {int retries = 2}) async {
    debugPrint('[$tag] GET $endpoint');
    for (int attempt = 1; attempt <= retries + 1; attempt++) {
      final client = _newClient();
      try {
        final response = await client
            .get(Uri.parse('$_baseUrl$endpoint'), headers: _getHeaders)
            .timeout(_timeout);
        debugPrint('[$tag] GET $endpoint → ${response.statusCode} (attempt $attempt)');
        return _handleResponse(response);
      } on TimeoutException catch (e) {
        debugPrint('[$tag] GET $endpoint timeout (attempt $attempt): $e');
        if (attempt > retries) rethrow;
      } on SocketException catch (e) {
        debugPrint('[$tag] GET $endpoint socket error (attempt $attempt): $e');
        if (attempt > retries) rethrow;
      } finally {
        client.close();
      }
    }
    throw Exception('fetch failed after ${retries + 1} attempts');
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    }
    throw Exception('HTTP ${response.statusCode}: ${response.body}');
  }
}
