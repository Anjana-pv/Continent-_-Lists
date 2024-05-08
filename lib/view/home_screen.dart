import 'package:country_list/controller/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final countryProvider = Provider.of<CountryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Continents'),
        centerTitle: true,
      ),
      body: countryProvider.countries.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: countryProvider.countries.length,
              itemBuilder: (context, index) {
                final country = countryProvider.countries[index];
                return ListTile(
                  title: Text(country.name),
                );
              },
            ),
    );
  }
}