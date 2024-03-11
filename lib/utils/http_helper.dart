import 'dart:convert';
import 'dart:io';

import 'package:flutter_sandbox/models/pizza.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  final String authority = 'gkvly.wiremockapi.cloud';
  final String path = '/pizzas';

  Future<List<Pizza>> getPizzas() async {
    final Uri url = Uri.https(authority, path);
    final http.Response response = await http.get(url);

    if (response.statusCode == HttpStatus.ok) {
      final List json = jsonDecode(response.body);
      List<Pizza> pizzas = json.map((item) => Pizza.fromJson(item)).toList();
      return pizzas;
    }

    return [];
  }
}
