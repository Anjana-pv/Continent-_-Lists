import 'dart:convert';
import 'dart:developer';

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

     try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as List;
        log(json[0].toString()); // Log the entire first object for debugging

        _countries.clear(); // Clear existing data before adding new
        _countries.addAll(json.map((country) => Country.fromJson(country)).toList());
        notifyListeners();
      } else {
        // Handle errors (e.g., print error message)
        log('Error fetching countries: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or other errors
      log('Error fetching countries: $error');
    }
  }
}