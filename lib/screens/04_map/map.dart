import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/05_detailed/spot.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};

  final LatLng _center = const LatLng(37.5758772, 126.9768121);
  final _list = ['서울', '대구', '포항', '대전'];
  String _selectedCity = '';
  void initState() {
    super.initState();
    setState(() {
      _selectedCity = _list[0];
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker_1'),
          position: LatLng(37.54399751021019, 127.04642327420501),
          infoWindow: InfoWindow(
              title: '오뜨로 성수',
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Info()));
              }),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 100,
            child: DropdownButton(
              //지역정하는 버튼
              value: _selectedCity,
              isExpanded: true,
              items: _list
                  .map((e) => DropdownMenuItem(
                        value: e, // 선택 시 onChanged 를 통해 반환할 value
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                // items 의 DropdownMenuItem 의 value 반환
                setState(() {
                  _selectedCity = value!;
                });
              },
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: _markers),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.95,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                color: Colors.white,
                child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: ListTile(
                                title: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Info()));
                                    },
                                    child: Text('일단 테스트'))),
                          ),
                        ),
                      ],
                    )),
              );
            },
          )
        ],
      ),
    );
  }
}
