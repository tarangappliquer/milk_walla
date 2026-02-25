import 'package:flutter/material.dart';
import 'package:mappls_gl/mappls_gl.dart';

class RideBookingPage extends StatefulWidget {
  const RideBookingPage({super.key});

  @override
  State<RideBookingPage> createState() => _RideBookingPageState();
}

class _RideBookingPageState extends State<RideBookingPage> {
  MapplsMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. The Map Layer
          MapplsMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(28.6139, 77.2090),
              zoom: 14.0,
            ),
            onMapCreated: (controller) => mapController = controller,
            myLocationEnabled: true,
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
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
