class Country {
  final String name;
  final List<String> capital;
  final int population;
  final String region;
  final String flag;
  final String continent;

  Country({
    required this.name,
    required this.capital,
    required this.population,
    required this.region,
    required this.flag,
     required this.continent,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    String continent = json['region'] ?? 'Other';
  return Country(
        
        name: json['name']['common'],
        capital: json['capital']?.cast<String>() ?? [],
        population: json['population'],
        region: json['region'],
        flag: json['flags']['png'],
        continent: continent,
      );
}
}
class Continent {
  final String name;
  final List<Country> countries;

  Continent({
    required this.name,
    required this.countries,
  });
}