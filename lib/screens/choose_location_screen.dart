import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChooseLocationScreen extends StatefulWidget {
  const ChooseLocationScreen({super.key});

  @override
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  GoogleMapController? _controller;
  final LatLng _initial = const LatLng(37.7749, -122.4194);
  final Set<Marker> _markers = {
    const Marker(markerId: MarkerId('pin'), position: LatLng(37.7749, -122.4194)),
  };

  bool get _mapsSupported {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android; // Android only
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacementNamed(context, '/location'),
        ),
        centerTitle: true,
        title: const Text(
          'Choose Location',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Map area
          SizedBox(
            height: 240,
            child: _mapsSupported
                ? GoogleMap(
                    initialCameraPosition: CameraPosition(target: _initial, zoom: 13),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    markers: _markers,
                    onMapCreated: (c) => _controller = c,
                    onTap: (pos) {
                      setState(() {
                        _markers
                          ..clear()
                          ..add(Marker(markerId: const MarkerId('pin'), position: pos));
                      });
                    },
                  )
                : Container(
                    color: const Color(0xFFE7F0EA),
                    alignment: Alignment.center,
                    child: const Text('Map not supported on this platform',
                        style: TextStyle(color: Colors.black54)),
                  ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: const Icon(Icons.tune, color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFFF3F5F7),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Popular Location', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 8),
                _locationTile('Los Angeles', 'California, United States', '3.21 KM'),
                const Divider(height: 1),
                _locationTile('San Francisco', '2118 Thornridge Cir. Syracuse...', '2.24 KM'),
                const Divider(height: 1),
                _locationTile('New York', '2118 Thornridge Cir. Syracuse...', '2.84 KM'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationTile(String title, String subtitle, String distance) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        radius: 16,
        backgroundColor: Color(0xFFE7F0EA),
        child: Icon(Icons.location_on, color: Colors.green, size: 18),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
      trailing: Text(distance, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
      onTap: () {
        // In a real app, set the selected location and pop back
      },
    );
  }
}
