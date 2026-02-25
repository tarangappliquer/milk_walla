import 'dart:math';

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_polyline_algorithm/google_polyline_algorithm.dart';
import 'package:mappls_gl/mappls_gl.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapplsMapController mapController;

  Future _onMapCreated(MapplsMapController controller) async {
    mapController = controller;
    await Future.delayed(const Duration(seconds: 2));

    final latlng1 = LatLng(28.594475, 77.202432);
    final latlng2 = LatLng(28.554676, 77.186982);

    await controller.addSymbol(SymbolOptions(geometry: latlng1));
    await controller.addSymbol(SymbolOptions(geometry: latlng2));

    await controller.animateCamera(.newLatLngZoom(latlng1, 16.0));

    try {
      DirectionResponse? directionResponse = await MapplsDirection(
        origin: latlng1,
        destination: latlng2,
      ).callDirection();

      if (directionResponse != null &&
          directionResponse.routes != null &&
          directionResponse.routes!.isNotEmpty) {
        String? encodedPolyline = directionResponse.routes![0].geometry;

        if (encodedPolyline != null && encodedPolyline.isNotEmpty) {
          List<List<num>> decodedCoords = decodePolyline(
            encodedPolyline,
            accuracyExponent: 6,
          );
          List<LatLng> latLngList = decodedCoords
              .map(
                (coords) => LatLng(coords[0].toDouble(), coords[1].toDouble()),
              )
              .toList();
          await controller.addLine(
            LineOptions(
              geometry: latLngList,
              lineColor: "#3bb2d0",
              lineWidth: 4,
            ),
          );
        }
      }
    } catch (e) {
      PlatformException map = e as PlatformException;

      if (kDebugMode) {
        debugPrint(map.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mappls Map Demo")),
      body: MapplsMap(
        compassViewMargins: Point(20, 10),
        onMapCreated: _onMapCreated,
        onMapError: (code, message) {
          final snackBar = SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(28.551087, 77.257373),
          zoom: 12.0,
        ),
        onMapClick: (point, latlng) {
          final snackBar = SnackBar(
            content: Text("Map clicked at: ${latlng.toString()}"),
            duration: const Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          if (kDebugMode) {
            debugPrint(latlng.toString());
          }
        },
        myLocationEnabled: true,
        onUserLocationUpdated: (location) => {},
      ),
    );
  }
}
