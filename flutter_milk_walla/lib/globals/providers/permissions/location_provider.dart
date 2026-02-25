import 'package:location/location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_provider.g.dart';

@riverpod
class UserLocation extends _$UserLocation {
  @override
  Stream<LocationData> build() async* {
    Location location = Location();

    await location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 5000,
      distanceFilter: 10,
    );

    // Permission Logic
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) throw Exception('Location service disabled');
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw Exception('Location permission denied');
      }
    }

    yield* location.onLocationChanged;
  }

  // Method to be called by the RefreshIndicator
  Future<void> retry() async {
    ref.invalidateSelf();
  }
}
