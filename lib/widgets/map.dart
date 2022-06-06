import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GPSMap extends StatelessWidget {
  double longitude;
  double latitude;
  GPSMap({Key? key, this.latitude = 0, this.longitude = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var initialCameraPostion =
        CameraPosition(target: LatLng(latitude, longitude), zoom: 11.5);
    Marker destination = Marker(
        markerId: const MarkerId('location'),
        infoWindow: const InfoWindow(title: 'Location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(latitude, longitude));
    return GoogleMap(
      myLocationButtonEnabled: false,
      initialCameraPosition: initialCameraPostion,
      markers: {if (destination != null) destination},
    );
  }
}
