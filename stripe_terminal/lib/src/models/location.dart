import 'package:mek_data_class/mek_data_class.dart';

part 'location.g.dart';

class Location {
  final Address? address;
  final String? displayName;
  final String? id;
  final bool? livemode;
  final Map<String, String> metadata;

  const Location({
    required this.address,
    required this.displayName,
    required this.id,
    required this.livemode,
    required this.metadata,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      displayName: json['displayName'],
      id: json['id'],
      livemode: json['livemode'],
      metadata: Map<String, String>.from(json['metadata'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address?.toJson(),
      'displayName': displayName,
      'id': id,
      'livemode': livemode,
      'metadata': metadata,
    };
  }
}

class Address {
  final String? city;
  final String? country;
  final String? line1;
  final String? line2;
  final String? postalCode;
  final String? state;

  const Address({
    required this.city,
    required this.country,
    required this.line1,
    required this.line2,
    required this.postalCode,
    required this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      country: json['country'],
      line1: json['line1'],
      line2: json['line2'],
      postalCode: json['postalCode'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
      'line1': line1,
      'line2': line2,
      'postalCode': postalCode,
      'state': state,
    };
  }
}
