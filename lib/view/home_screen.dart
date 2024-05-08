import 'package:country_list/controller/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CountryProvider>(context, listen: false).fetchCountries(); // Fetch initially, avoid rebuild
  }

  @override
  Widget build(BuildContext context) {
    final countryProvider = Provider.of<CountryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Continents'),
        centerTitle: true,
      ),
      body: countryProvider.countries.isEmpty
          ? const Center(child: CircularProgressIndicator())
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