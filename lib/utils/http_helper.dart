import 'dart:convert';
import 'dart:io';

import 'package:flutter_sandbox/models/pizza.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  // Singleton
  static final HttpHelper _httpHelper = HttpHelper._internal();
  factory HttpHelper() {
    return _httpHelper;
  }
  HttpHelper._internal();

  final String authority = 'gkvly.wiremockapi.cloud';

  Future<List<Pizza>> getPizzas() async {
    const String path = '/pizzas';
    final Uri url = Uri.https(authority, path);
    final http.Response response = await http.get(url);

    if (response.statusCode >= HttpStatus.ok &&
        response.statusCode < HttpStatus.multipleChoices) {
      final List<Map<String, dynamic>> json =
          jsonDecode(response.body) as List<Map<String, dynamic>>;
      final List<Pizza> pizzas =
          json.map((item) => Pizza.fromJson(item)).toList();
      return pizzas;
    }

    return [];
  }

  Future<String> postPizza(Pizza pizza) async {
    const String path = '/pizza';
    final String body = json.encode(pizza.toJson());
    final Uri url = Uri.https(authority, path);
    final http.Response response = await http.post(url, body: body);

    if (response.statusCode >= HttpStatus.ok &&
        response.statusCode < HttpStatus.multipleChoices) {
      final String message = _getResponseMessage(response);
      return message;
    }

    return 'Something went wrong.';
  }

  Future<String> putPizza(PartialPizza pizza) async {
    final String path = '/pizza/${pizza.id}';
    final String body = json.encode(pizza.toJson());
    final Uri url = Uri.https(authority, path);
    final http.Response response = await http.put(url, body: body);

    if (response.statusCode >= HttpStatus.ok &&
        response.statusCode < HttpStatus.multipleChoices) {
      final String message = _getResponseMessage(response);
      return message;
    }

    return 'Something went wrong.';
  }

  Future<String> deletePizza(int id) async {
    final String path = '/pizza/$id';
    final Uri url = Uri.https(authority, path);
    final http.Response response = await http.delete(url);

    if (response.statusCode >= HttpStatus.ok &&
        response.statusCode < HttpStatus.multipleChoices) {
      final String message = _getResponseMessage(response);
      return message;
    }

    return 'Something went wrong.';
  }

  String _getResponseMessage(http.Response response) {
    final dynamic json = jsonDecode(response.body);
    final String? message =
        json is Map<dynamic, String> ? json['message'] : "";

    if (message is String) {
      return message;
    }

    throw const FormatException('Invalid response');
  }
}
