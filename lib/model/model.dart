class Country {
  final String name;
  final List<String> capital;
  final int population;
  final String region;
  final String flag;

  Country({
    required this.name,
    required this.capital,
    required this.population,
    required this.region,
    required this.flag,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json['name']['common'],
        capital: json['capital']?.cast<String>() ?? [],
        population: json['population'],
        region: json['region'],
        flag: json['flags']['png'],
      );
}