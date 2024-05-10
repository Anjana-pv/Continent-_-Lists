
import 'package:country_list/model/model.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

    void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
  List<Country> getFilteredCountries(List<Country> countries) {
    return countries.where((country) {
      return country.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }
  
}