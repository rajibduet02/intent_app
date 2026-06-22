class MatchProfile {
  const MatchProfile({
    required this.id,
    required this.name,
    required this.age,
    required this.location,
    required this.compatibilityPercent,
    required this.sharedValuesCount,
  });

  final String id;
  final String name;
  final int age;
  final String location;
  final int compatibilityPercent;
  final int sharedValuesCount;

  static const List<MatchProfile> samples = [
    MatchProfile(
      id: 'jordan',
      name: 'Jordan',
      age: 28,
      location: 'Brooklyn, NY',
      compatibilityPercent: 92,
      sharedValuesCount: 2,
    ),
    MatchProfile(
      id: 'taylor',
      name: 'Taylor',
      age: 27,
      location: 'Austin, TX',
      compatibilityPercent: 88,
      sharedValuesCount: 2,
    ),
    MatchProfile(
      id: 'casey',
      name: 'Casey',
      age: 30,
      location: 'Seattle, WA',
      compatibilityPercent: 91,
      sharedValuesCount: 2,
    ),
    MatchProfile(
      id: 'morgan',
      name: 'Morgan',
      age: 29,
      location: 'Chicago, IL',
      compatibilityPercent: 85,
      sharedValuesCount: 2,
    ),
    MatchProfile(
      id: 'riley',
      name: 'Riley',
      age: 31,
      location: 'Denver, CO',
      compatibilityPercent: 90,
      sharedValuesCount: 2,
    ),
  ];
}
