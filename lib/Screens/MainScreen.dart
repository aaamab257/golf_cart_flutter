import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loginandregister_flutter/Screens/common.dart';
import 'package:loginandregister_flutter/Screens/drwar.dart';
import 'package:loginandregister_flutter/Screens/select_address.dart';
import 'package:shimmer/shimmer.dart';
import '../Screens/address_search.dart';
import '../Screens/places_services.dart';
import 'package:uuid/uuid.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool is_driver = true;
  bool search_for_driver = false;
  bool driving_to_student = false;
  bool trip_rejected = false;
  TextEditingController _addressController = TextEditingController();
  @override
  void initState() {
    addMarkers();
    super.initState();
  }

  PolylinePoints polylinePoints = PolylinePoints();
  final _controller = TextEditingController();
  String googleAPiKey = "AIzaSyCZVhSxXxklm1gTrpb7JnIOE5m6wWfvmz4";

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = LatLng(21.5799164, 39.1829549);
  LatLng endLocation = LatLng(21.5807469, 39.1818552);

  final Set<Polyline> _polyline = {};

  List<LatLng> latLen = [
    LatLng(21.5799164, 39.1829549),
    LatLng(21.5807469, 39.1818552),
  ];

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  void addMarkers() async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      is_driver ? "Assets/user.png" : "Assets/marker.png",
    );
    markers.add(Marker(
      icon: markerbitmap,
      markerId: MarkerId('1'),
      position: LatLng(21.5807469, 39.1818552),
      infoWindow: InfoWindow(
        title: is_driver ? 'Hind AlMalki' : 'Golf Cart 1274',
        snippet: is_driver ? 'Student' : 'Bayan',
      ),
    ));
    markers.add(Marker(
      icon: markerbitmap,
      markerId: MarkerId('2'),
      position: LatLng(21.5789312, 39.1829549),
      infoWindow: InfoWindow(
        title: is_driver ? 'Hind AlMalki' : 'Golf Cart 1274',
        snippet: is_driver ? 'Student' : 'Hind',
      ),
    ));
    markers.add(Marker(
      icon: markerbitmap,
      markerId: MarkerId('3'),
      position: LatLng(21.579854, 39.1813372),
      infoWindow: InfoWindow(
        title: is_driver ? 'Hind AlMalki' : 'Golf Cart 1274',
        snippet: is_driver ? 'Student' : 'Fatimah',
      ),
    ));
    getDirections();
  }

  void onMapcreated(GoogleMapController controller) {
    setState(() {
      addMarkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    GoogleMapController mapController;
    LatLng initialLocation = const LatLng(21.5790754, 39.1837738);
    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    return SafeArea(
      child: Scaffold(
          drawer: mainDrawer(context),
          backgroundColor: Colors.white,
          body: buildAppScaffold(
            context,
            Column(
              children: [
                Expanded(
                  child: GoogleMap(
                    mapToolbarEnabled: true,
                    buildingsEnabled: false,
                    mapType: MapType.normal,
                    markers: markers,
                    onMapCreated: onMapcreated,
                    zoomControlsEnabled: true,
                    myLocationButtonEnabled: false,
                    polylines: Set<Polyline>.of(polylines.values),
                    initialCameraPosition: CameraPosition(
                      target: initialLocation,
                      zoom: 16,
                    ),
                  ),
                ),
                is_driver
                    ? trip_rejected
                        ? Padding(
                            padding: EdgeInsets.all(25),
                            child: Text(
                              'Wait for Another Trip ...',
                              style: TextStyle(color: Colors.green),
                            ),
                          )
                        : tripFromTo(context)
                    : search_for_driver
                        ? Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Text(
                              'Waiting for your driver ',
                              style: TextStyle(color: Colors.green),
                            ),
                          )
                        : Column(
                            children: [
                              ListTile(
                                title: Text(
                                  'Where Are you Going !',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  'Select or type your trip here ...',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: 15, left: 10, right: 10),
                                child: TextFormField(
                                  onTap: () async {
                                    final sessionToken = Uuid().v4();
                                    final Suggestion result = await showSearch(
                                      context: context,
                                      delegate: AddressSearch(sessionToken),
                                    );
                                    // This will change the text displayed in the TextField
                                    if (result != null) {
                                      final placeDetails =
                                          await PlaceApiProvider(sessionToken)
                                              .getPlaceDetailFromId(
                                                  result.placeId);
                                      setState(() {
                                        _addressController.text =
                                            result.description;
                                        _addressController.text =
                                            'القبول والتسجيل';
                                      });
                                    }
                                  },
                                  controller: _addressController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Where are you going ?';
                                    }
                                    return null;
                                  },
                                  decoration: new InputDecoration(
                                    labelText: 'Where are you going !',
                                    border: OutlineInputBorder(),
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 15.0, horizontal: 10.0),
                                  ),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) =>
                                      FocusScope.of(context)
                                          .nextFocus(), // move focus to next
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: OutlinedButton(
                                  onPressed: () {
                                    if (!_addressController.text.isEmpty) {
                                      setState(() {
                                        search_for_driver = true;
                                      });
                                    }
                                  },
                                  child: Text(
                                    'Ride Now',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                              )
                            ],
                          ),
                is_driver
                    ? Container(
                        height: 80,
                        child: driving_to_student
                            ? Text(
                                'Driving to Student ... ',
                                style: TextStyle(color: Colors.green),
                              )
                            : trip_rejected
                                ? Padding(
                                    padding: EdgeInsets.all(25),
                                    child: SizedBox())
                                : Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: OutlinedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: const Text(
                                                    "Student waiting ..."),
                                                content: const Text(
                                                    "Student Location : كلية الاداب والعلوم"),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        driving_to_student =
                                                            true;
                                                        Navigator.of(ctx).pop();
                                                      });
                                                    },
                                                    child: Container(
                                                      color: Colors.green,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              14),
                                                      child: const Text(
                                                        "Okay",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Accept',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        ),
                                      )),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: OutlinedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  title: const Text("Rejected"),
                                                  content: const Text(
                                                      "Are you sure to reject this trip !"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          trip_rejected = true;
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        });
                                                      },
                                                      child: Container(
                                                        color: Colors.red,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(14),
                                                        child: const Text(
                                                          "Reject",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Reject',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                      )
                    : SizedBox()
              ],
            ),
          )),
    );
  }

  Widget tripFromTo(BuildContext context) => Column(children: [
        ListTile(
          title: Text('Trip From '),
        ),
        ListTile(
          leading: Icon(
            Icons.person,
            size: 50,
          ),
          title: Text('Hind Almalki'),
        ),
        ListTile(
          title: Text('Trip Details '),
        ),
        ListTile(
            leading: Icon(Icons.person_pin_circle),
            title: Text(
              'كلية الاداب والعلوم',
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Row(children: [
              Text(
                'From',
                style: TextStyle(color: Colors.green),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).textTheme.bodyText1?.color ??
                          Colors.white)),
              Text('Computer Science Collage',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12))
            ])),
        ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: Text(
              'عمادة القبول والتسجيل شطر الطالبات',
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Row(children: [
              const Text(
                'To',
                style: TextStyle(color: Colors.green),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 3,
                  height: 3,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).textTheme.bodyText1?.color ??
                          Colors.white)),
              Text('عمادة القبول والتسجيل شطر الطالبات',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12))
            ]))
      ]);
}
