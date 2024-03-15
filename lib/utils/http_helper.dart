import 'dart:convert';
import 'dart:io';

import 'package:flutter_sandbox/models/pizza.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  // Singleton
  static final HttpHelper _httpHelper = HttpHelper._internal();
  HttpHelper._internal();
  factory HttpHelper() {
    return _httpHelper;
  }

  final String authority = 'gkvly.wiremockapi.cloud';

  Future<List<Pizza>> getPizzas() async {
    const String path = '/pizzas';
    final Uri url = Uri.https(authority, path);
    final http.Response response = await http.get(url);

    if (response.statusCode >= HttpStatus.ok &&
        response.statusCode < HttpStatus.multipleChoices) {
      final List json = jsonDecode(response.body);
      List<Pizza> pizzas = json.map((item) => Pizza.fromJson(item)).toList();
      return pizzas;
    }

    return [];
  }

  Future<String> postPizza(Pizza pizza) async {
    const String path = '/pizza';
    String body = json.encode(pizza.toJson());
    final Uri url = Uri.https(authority, path);
    final http.Response response = await http.post(url, body: body);

    if (response.statusCode >= HttpStatus.ok &&
        response.statusCode < HttpStatus.multipleChoices) {
      final Map json = jsonDecode(response.body);
      return json['message'];
    }

    return 'Something went wrong.';
  }

  Future<String> putPizza(PartialPizza pizza) async {
    final String path = '/pizza/${pizza.id}';
    String body = json.encode(pizza.toJson());
    final Uri url = Uri.https(authority, path);
    final http.Response response = await http.put(url, body: body);

    if (response.statusCode >= HttpStatus.ok &&
        response.statusCode < HttpStatus.multipleChoices) {
      final Map json = jsonDecode(response.body);
      return json['message'];
    }

    return 'Something went wrong.';
  }

  Future<String> deletePizza(int id) async {
    final String path = '/pizza/$id';
    final Uri url = Uri.https(authority, path);
    final http.Response response = await http.delete(url);

    if (response.statusCode >= HttpStatus.ok &&
        response.statusCode < HttpStatus.multipleChoices) {
      final Map json = jsonDecode(response.body);
      return json['message'];
    }

    return 'Something went wrong.';
  }
}
