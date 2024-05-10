import 'package:country_list/controller/country_provider.dart';
import 'package:country_list/controller/search_provider.dart';
import 'package:country_list/view/details_screen.dart';

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
    Provider.of<CountryProvider>(context, listen: false).fetchAndGroupCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Continents'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by country name...',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                Provider.of<SearchProvider>(context, listen: false)
                    .setSearchQuery(value);
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshCountries,
              child: Consumer2<CountryProvider, SearchProvider>(
                builder: (context, countryProvider, searchProvider, child) {
                  final searchQuery = searchProvider.searchQuery.toLowerCase();
                  final searchResult = countryProvider.continents
                      .expand((continent) => continent.countries)
                      .where((country) =>
                          country.name.toLowerCase().contains(searchQuery))
                      .toList();
              
                  return ListView.builder(
                    itemCount: searchQuery.isEmpty
                        ? countryProvider.continents.length
                        : searchResult.length,
                    itemBuilder: (context, index) {
                      if (searchQuery.isEmpty) {
                        final continent = countryProvider.continents[index];
                        return ExpansionTile(
                          title: Text(continent.name),
                          subtitle:
                              Text('Countries: ${continent.countries.length}'),
                          children: continent.countries
                              .map((country) => ListTile(
                                    leading: Image.network(
                                      country.flag,
                                      width: 60,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(country.name),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Capital: ${country.capital}'),
                                        Text('Population: ${country.population}'),
                                      ],
                                    ),
                                   onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DiscrptionScreen(country: country),
                                        ),
                                      );
                                    },
                                  ))
                              .toList(),
                        );
                      } else {
                        final country = searchResult[index];
                        return ListTile(
                          leading: Image.network(
                            country.flag,
                            width: 60,
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
                         onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DiscrptionScreen(country: country),
                              ),
                            );
                         }
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
   Future<void> _refreshCountries() async {
    await Provider.of<CountryProvider>(context, listen: false).fetchAndGroupCountries();
  }

}