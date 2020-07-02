import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow:
            InfoWindow(title: 'This is gofixit map', snippet: 'Gofixit'),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  _onTyped() {
    setState(() {});
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Color(0xFF263238),
      child: Icon(
        icon,
        size: 29.0,
      ),
    );
  }

  Widget searchTextField(Function funciton, String placeholder) {
    return Container(
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      height: 45.0,
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.location_on, color: Colors.red),
          hintText: placeholder,
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
        ),
      ),
    );
  }

  _searchNavigate() {
    // Geolocator().placemarFromAddress(searchAddr).then((result){
    //   mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition))
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gofixit map screen"),
        backgroundColor: Color(0xFF263238),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),
          Container(
            child: Column(
              children: [
                Expanded(
                    child: Container(
                  // color:Colors.pink,
                  child: null,
                )),
                Expanded(
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    decoration: BoxDecoration(
                      // color: Colors.grey[50],
                      // color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    height: MediaQuery.of(context).copyWith().size.height,
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 10.0,
                        ),
                        searchTextField(_onTyped(), "pick up"),
                        SizedBox(
                          height: 10.0,
                        ),
                        searchTextField(_onTyped(), "delivery"),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextArea(
                          placeholder: "Description",
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                          label: "Request Delivery",
                        ),
                        SizedBox(
                          height: 60.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: MediaQuery.of(context).copyWith().size.height,
                  // color:Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // button(_onMapTypeButtonPressed, Icons.map),
                      // SizedBox(height: 10.0),
                      // button(_onAddMarkerButtonPressed, Icons.location_on),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// AIzaSyDqj76idU0QHy_NqMNeXwCcaDdD-siNYF4   //GOOOGLE MAP API KEY

class ElevatedButton extends StatelessWidget {
  ElevatedButton({this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Container(
        child: Center(
            child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        )),
        height: 45.0,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 7,
              blurRadius: 9,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          // gradient: LinearGradient(
          //     colors: [
          //       // const Color(0xFF3366FF),
          //       Colors.red,
          //       Colors.black,
          //     ],
          //     begin: const FractionalOffset(0.0, 0.0),
          //     end: const FractionalOffset(1.0, 0.0),
          //     stops: [0.0, 1.0],
          //     tileMode: TileMode.clamp),
        ),
      ),
    );
  }
}

class TextArea extends StatelessWidget {
  TextArea({this.placeholder});
  final String placeholder;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]),
      height: 70.0,
      child: TextFormField(
        maxLines: 2,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
