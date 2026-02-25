import 'package:flutter_milk_walla/globals/providers/permissions/location_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:mappls_gl/mappls_gl.dart';

class RideBookingPage extends ConsumerStatefulWidget {
  const RideBookingPage({super.key});

  @override
  ConsumerState<RideBookingPage> createState() => _RideBookingPageState();
}

class _RideBookingPageState extends ConsumerState<RideBookingPage> {
  late MapplsMapController mapController;

  @override
  Widget build(BuildContext context) {
    final locationAsync = ref.watch(userLocationProvider);
    return Scaffold(
      body: locationAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => RefreshIndicator(
          onRefresh: () => ref.read(userLocationProvider.notifier).retry(),
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_off,
                          size: 80,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '$err',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        const Text("Please pull down to try again"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        data: (location) {
          return Stack(
            children: [
              // 1. The Map Layer
              MapplsMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(28.6139, 77.2090),
                  zoom: 14.0,
                ),
                onMapCreated: (controller) => mapController = controller,
                myLocationEnabled: true,
                myLocationTrackingMode: MyLocationTrackingMode.trackingGps,
                myLocationRenderMode: MyLocationRenderMode.gps,
                compassEnabled: true,
                compassViewPosition: CompassViewPosition.bottomLeft,
                onUserLocationUpdated: (location) async {
                  await mapController.addSymbol(
                    SymbolOptions(geometry: location.position),
                  );
                },
              ),

              // 2. The Sliding "Ride Options" Panel
              DraggableScrollableSheet(
                initialChildSize: 0.3, // Starts at 30% height
                minChildSize: 0.15, // Can be collapsed to 15%
                maxChildSize: 0.9, // Can be expanded to 90%
                builder: (context, scrollController) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(blurRadius: 10, color: Colors.black12),
                      ],
                    ),
                    child: ListView(
                      controller: scrollController,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            "Where to?",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        _buildRideOption(
                          "Mappls Mini",
                          "4 mins away",
                          "₹150",
                          Icons.directions_car,
                        ),
                        _buildRideOption(
                          "Mappls Sedan",
                          "2 mins away",
                          "₹220",
                          Icons.local_taxi,
                        ),
                        _buildRideOption(
                          "Mappls XL",
                          "7 mins away",
                          "₹450",
                          Icons.airport_shuttle,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text("CONFIRM BOOKING"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRideOption(
    String name,
    String eta,
    String price,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon, size: 40, color: Colors.blueGrey),
      title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(eta),
      trailing: Text(
        price,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
