class Place {
  String id;
  _Location location;
  _DisplayName displayName;
  String formattedAddress;

  Place({
    required this.id,
    required this.location,
    required this.displayName,
    required this.formattedAddress,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json["id"] as String,
        location: _Location.fromJson(json["location"] as Map<String, dynamic>),
        displayName:
            _DisplayName.fromJson(json["displayName"] as Map<String, dynamic>),
        formattedAddress: json["formattedAddress"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location.toJson(),
        "displayName": displayName.toJson(),
      };
}

class _DisplayName {
  String text;
  String languageCode;

  _DisplayName({
    required this.text,
    required this.languageCode,
  });

  factory _DisplayName.fromJson(Map<String, dynamic> json) => _DisplayName(
        text: json["text"] as String,
        languageCode: json["languageCode"] as String,
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "languageCode": languageCode,
      };
}

class _Location {
  double latitude;
  double longitude;

  _Location({
    required this.latitude,
    required this.longitude,
  });

  factory _Location.fromJson(Map<String, dynamic> json) => _Location(
        latitude: double.tryParse(json["latitude"].toString()) ?? 0,
        longitude: double.tryParse(json["longitude"].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
