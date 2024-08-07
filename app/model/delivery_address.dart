import 'package:google_maps_flutter/google_maps_flutter.dart';



/// timestamp : {"created_at":"12-11-2023, 7:48:51PM","updated_at":"12-11-2023, 7:49:02PM"}
/// _id : "65771a5660af90f073f974cf"
/// user_id : "657426ed611117948aa21764"
/// location_name : "Payyanangadi"
/// geocoordinates : "45.21.25,46.32.11"
/// streetAddress : "Vailathur road"
/// flat_house_building : "PP Manzil"
/// landmark : "Near Juma Masjid"
/// city : "Tirur"
/// district : "Malappuram"
/// state : "Kerala"
/// country : "India"
/// address_type : "Home"
/// mobile : 8606193582
/// status : 1
/// default : 0
/// __v : 0

class AddressDetails {
  AddressDetails({
    this.id,
    this.userId,
    this.locationName,
    this.geocoordinates,
    this.streetAddress,
    this.flatHouseBuilding,
    this.landmark,
    this.city,
    this.district,
    this.state,
    this.country,
    this.addressType,
    this.mobile,
    this.status,
    this.defaultValue,
    this.v,
  });

  AddressDetails.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['user_id'];
    locationName = json['location_name'];
    geocoordinates = json['geocoordinates'];
    streetAddress = json['streetAddress'];
    flatHouseBuilding = json['flat_house_building'];
    landmark = json['landmark'];
    city = json['city'];
    district = json['district'];
    state = json['state'];
    country = json['country'];
    addressType = json['address_type'];
    mobile = json['mobile'];
    status = json['status'];
    defaultValue = json['default'];
    v = json['__v'];
  }

  String? id;
  String? userId;
  String? locationName;
  String? geocoordinates;
  String? streetAddress;
  String? flatHouseBuilding;
  String? landmark;
  String? city;
  String? district;
  String? state;
  String? country;
  String? addressType;
  dynamic mobile;
  num? status;
  num? defaultValue;
  num? v;

  LatLng? getLatAndLng() {
    final coordinates = geocoordinates?.split(",");
    if (coordinates?.isNotEmpty == true) {
      return LatLng(double.parse(coordinates![0]), double.parse(coordinates[1]));
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['location_name'] = locationName;
    map['geocoordinates'] = geocoordinates;
    map['streetAddress'] = streetAddress;
    map['flat_house_building'] = flatHouseBuilding;

    if (landmark?.isNotEmpty == true) map['landmark'] = landmark;
    if (mobile?.isNotEmpty == true) map['mobile'] = mobile;

    map['city'] = city ?? locationName;
    map['district'] = district;
    map['state'] = state;
    map['address_type'] = addressType ?? "Home";
    map['default'] = defaultValue;

    return map;
  }
}
