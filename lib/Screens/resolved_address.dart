import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class ResolvedAddress {
  Location location;
  String mainText;
  String secondaryText;

  LatLng get toLatLng => LatLng(location.lat, location.lng);

  ResolvedAddress({
    this.location,
    this.mainText,
    this.secondaryText,
  });
}
