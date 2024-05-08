import 'package:mek_data_class/mek_data_class.dart';
import 'package:mek_stripe_terminal/mek_stripe_terminal.dart';
part 'reader.g.dart';

/// The possible reader connection statuses for the SDK.
enum ConnectionStatus {
  /// The SDK is not connected to a reader.
  notConnected,

  /// The SDK is connected to a reader.
  connected,

  /// The SDK is currently connecting to a reader.
  connecting
}

/// Information about a card reader that has been discovered by or connected to the SDK.
///
/// Some of the properties are only applicable to a certain device type. These properties are
/// labeled with the reader or reader type to which they apply.
@DataClass()
class Reader with _$Reader {
  final LocationStatus? locationStatus;
  final DeviceType? deviceType;
  final bool simulated;
  final String? locationId;
  final Location? location;
  final String serialNumber;
  final bool availableUpdate;
  final double batteryLevel;
  final String? label;

  const Reader({
    required this.locationStatus,
    required this.batteryLevel,
    required this.deviceType,
    required this.simulated,
    required this.availableUpdate,
    required this.serialNumber,
    required this.locationId,
    required this.location,
    required this.label,
  });

  factory Reader.fromJson(Map<String, dynamic> json) {
    return Reader(
      locationStatus: json['locationStatus'] != null
          ? LocationStatus.values[json['locationStatus']]
          : null,
      deviceType: json['deviceType'] != null
          ? DeviceType.values[json['deviceType']]
          : null,
      simulated: json['simulated'] ?? false,
      locationId: json['locationId'],
      location:
          json['location'] != null ? Location.fromJson(json['location']) : null,
      serialNumber: json['serialNumber'],
      availableUpdate: json['availableUpdate'] ?? false,
      batteryLevel: json['batteryLevel'] ?? 0.0,
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationStatus': locationStatus?.index,
      'deviceType': deviceType?.index,
      'simulated': simulated,
      'locationId': locationId,
      'location': location?.toJson(),
      'serialNumber': serialNumber,
      'availableUpdate': availableUpdate,
      'batteryLevel': batteryLevel,
      'label': label,
    };
  }
}

/// Represents the possible states of the location object for a discovered reader.
enum LocationStatus {
  /// The location was successfully set to a known location. location is a valid [Location].
  set,

  /// This location is known to be not set. location will be null.
  notSet
}

/// The reader’s device type.
enum DeviceType {
  /// Chipper 1X aka Chip & Swipe
  chipper1X,

  /// The BBPOS Chipper 2X BT mobile reader.
  chipper2X,

  /// The Stripe Reader M2 mobile reader.
  stripeM2,

  /// COTS Device.
  cotsDevice,

  /// The Verifone P400 countertop reader.
  verifoneP400,

  /// Wisecube aka Wisepad 2 aka Tap & Chip.
  wiseCube,

  /// The BBPOS WisePad 3 mobile reader.
  wisePad3,

  /// The BBPOS WisePad 3S mobile reader.
  wisePad3s,

  /// The BBPOS WisePOS E countertop reader.
  wisePosE,

  /// The BBPOS WisePOS E DevKit countertop reader.
  wisePosEDevkit,

  /// ETNA.
  etna,

  /// Stripe Reader S700.
  stripeS700,

  /// Stripe Reader S700 DevKit.
  stripeS700Devkit,

  /// Apple Built-In reader.
  appleBuiltIn,
}

/// A categorization of a reader’s battery charge level.
enum BatteryStatus {
  /// The device’s battery is less than or equal to 5%.
  critical(0.00, 0.05),

  /// The device’s battery is between 5% and 20%.
  low(0.05, 0.20),

  /// The device’s battery is greater than 20%.
  nominal(0.20, 1.00);

  final double minLevel;
  final double maxLevel;

  const BatteryStatus(this.minLevel, this.maxLevel);

  static BatteryStatus? from(double level) {
    if (level == -1) return null;
    return BatteryStatus.values
        .singleWhere((e) => level > e.minLevel && level < e.maxLevel);
  }
}

enum ReaderEvent { cardInserted, cardRemoved }

enum ReaderDisplayMessage {
  checkMobileDevice,
  retryCard,
  insertCard,
  insertOrSwipeCard,
  swipeCard,
  removeCard,
  multipleContactlessCardsDetected,
  tryAnotherReadMethod,
  tryAnotherCard,
  cardRemovedTooEarly,
}

enum ReaderInputOption { insertCard, swipeCard, tapCard, manualEntry }
