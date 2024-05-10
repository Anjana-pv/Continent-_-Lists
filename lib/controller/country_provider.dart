import 'dart:convert';
import 'package:country_list/model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountryProvider extends ChangeNotifier {
  List<Continent> _continents = [];
  String _searchQuery = '';

  List<Continent> get continents => _continents;

  Future<void> fetchAndGroupCountries() async {
    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
    final responseData = json.decode(response.body) as List<dynamic>;
    final countries = responseData.map((json) => Country.fromJson(json)).toList();

    // Group countries by continent
    Map<String, List<Country>> continentMap = {};
    countries.forEach((country) {
      final continent = country.continent; // Assuming 'Other' for countries without a continent
      if (!continentMap.containsKey(continent)) {
        continentMap[continent] = [];
      }
      continentMap[continent]!.add(country);
    });

    // Create Continent objects
    _continents = continentMap.entries
        .map((entry) => Continent(name: entry.key, countries: entry.value))
        .toList();

    notifyListeners();
  }

  void setSearchQuery(String value) {
    _searchQuery = value.toLowerCase();
    notifyListeners();
  }

  List<Country> getFilteredCountries(List<Country> countries) {
    return countries.where((country) {
      return country.name.toLowerCase().contains(_searchQuery);
    }).toList();
  }
}