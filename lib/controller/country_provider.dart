import 'dart:convert';

import 'package:country_list/model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryProvider extends ChangeNotifier {
  List<Country> _countries = [];

  List<Country> get countries => _countries;

  Future<void> fetchCountries() async {
    const url = 'https://restcountries.com/v3.1/all';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      _countries = json.map((country) => Country.fromJson(country)).toList();
      notifyListeners(); 
    } else {
     debugPrint('not printed');
    }
  }
}