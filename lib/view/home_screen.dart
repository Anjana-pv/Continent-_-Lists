import 'package:country_list/controller/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CountryProvider>(context, listen: false)
        .fetchCountries(); // Fetch initially, avoid rebuild
  }

  @override
  Widget build(BuildContext context) {
    final countryProvider = Provider.of<CountryProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Continents'),
        centerTitle: true,
      ),
      body: Consumer<CountryProvider>(
        builder: (context, provider, child) {
          if (provider.continents.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: provider.continents.length,
              itemBuilder: (context, index) {
                final continent = provider.continents[index];
                return ExpansionTile(
                  title: Text(continent.name),
                  subtitle: Text('Countries: ${continent.countries.length}'),
                  children: continent.countries
                      .map((country) => ListTile(
                            leading: Image.network(
                              country.flag, width: 60,
                              height: 50, 
                              fit: BoxFit.cover,
                            ),
                            title: Text(country.name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Capital: ${country.capital}'),
                                Text('Population: ${country.population}'),
                              ],
                            ),
                          ))
                      .toList(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
