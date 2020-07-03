// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapSearch extends StatefulWidget {
  @override
  _MapSearchState createState() => _MapSearchState();
}

class _MapSearchState extends State<MapSearch> {
  GoogleMapController mapController;

  String searchAddr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: onMapCreated,
            initialCameraPosition:
                CameraPosition(target: LatLng(6.5244, 3.3792), zoom: 11.0),
          ),
          Positioned(
            top: 30.0,
            right: 15.0,
            left: 15.0,
            child: Container(
              height: 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter address',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: searchandNavigate,
                    iconSize: 30.0,
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    searchAddr = val;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  searchandNavigate() {
    print(searchAddr);
    Geolocator().placemarkFromAddress(searchAddr).then((value) {
      print(value);
      // mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      //     target:
      //         LatLng(value[0].position.latitude, value[0].position.longitude),
      //     zoom: 10.0)));
    });
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
