import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:geolocator/geolocator.dart';
import '../data/location_repository.dart';

part 'location_notifier.g.dart';

@riverpod
class LocationNotifier extends _$LocationNotifier {
  @override
  FutureOr<Position?> build() {
    // Initial state is null (no location yet)
    return null;
  }

  Future<void> getLocation() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(locationRepositoryProvider);
      final permission = await repository.checkPermissions();

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        return await repository.getCurrentLocation();
      }

      // If permission is denied, we can throw an error to be caught by the UI
      throw Exception('Permission Denied');
    });
  }
}
