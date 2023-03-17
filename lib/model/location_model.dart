class LocationModel {
  static LocationModel? fromNetwork(final Map? dataMap) {
    if (dataMap == null) return null;

    return LocationModel(
      id: dataMap['id']?.toString() ?? '',
      city: dataMap['city']?.toString() ?? '',
      country: dataMap['country']?.toString() ?? '',
      coordinateLatitude: double.tryParse(dataMap['coord']?['lat']?.toString() ?? '') ?? 0,
      coordinateLongitude: double.tryParse(dataMap['coord']?['lon']?.toString() ?? '') ?? 0,
    );
  }

  final String id;
  final String city;
  final String country;
  final double coordinateLatitude;
  final double coordinateLongitude;

  const LocationModel({
    required this.id,
    required this.city,
    required this.country,
    required this.coordinateLatitude,
    required this.coordinateLongitude,
  });
}