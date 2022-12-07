import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
   final Set<Polyline> _polyline = {};
   
   
List<LatLng> latLen = [
    LatLng(19.0759837, 72.8776559),
    LatLng(28.679079, 77.069710),
    LatLng(26.850000, 80.949997),
    LatLng(24.879999, 74.629997),
    LatLng(16.166700, 74.833298),
    LatLng(12.971599, 77.594563),
  ];
   Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
   int _markerIdCounter = 1;
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        polylines: _polyline,
        // markers:  markers: Set<Marker>.of(markers.values),,
         markers: Set<Marker>.of(markers.values),
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        // onPressed: _goToTheLake,
        onPressed: () async {

          
//////////////////////////?//////////?/????????????///?/?/?/?/?/?/?/?/?///?//?/?////?/?//?/?//?/?//


bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 


// Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);




Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);


              final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition( CameraPosition(

    target: LatLng(position.latitude, position.longitude),
    zoom: 14.4746,

  )));



 _polyline.add(
          Polyline(
            polylineId: PolylineId('1'),
            points: latLen,
            color: Colors.green,
          )
      );
      setState(() {
        
      });



//  controller.mark(
//   MarkerOptions(
//     position: LatLng(37.4219999, -122.0862462),
//   ),
// );

// Future.delayed(Duration(seconds: 2)).then((value) {

// final Marker marker = Marker(
//       markerId: MarkerId("1"),
//       position: LatLng(
//         position.latitude ,
//         position.longitude 
//       ),
//       infoWindow: InfoWindow(title: "markeer", snippet: '*'),
//       // onTap: () => _onMarkerTapped(markerId),
//       // onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
//       // onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
//     );

//  setState(() {
//       markers[MarkerId("1")] = marker;
//     });
// });

      
  }

  

        ,


        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }



  Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
}