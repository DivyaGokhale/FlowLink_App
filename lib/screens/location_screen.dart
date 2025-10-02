import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GoogleMapController? _mapController;
  LatLng _cameraTarget = const LatLng(37.7749, -122.4194); // Default: San Francisco
  Marker? _currentMarker;

  bool get _mapsSupported {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android; // Android only
  }

  Future<bool> _ensurePermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
      }
      return false;
    }
    return true;
  }

  Future<void> _useCurrentLocation() async {
    if (!_mapsSupported) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maps not supported on this platform')),
      );
      return;
    }
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled')),
      );
      return;
    }
    if (!await _ensurePermission()) return;
    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final LatLng target = LatLng(pos.latitude, pos.longitude);
    setState(() {
      _cameraTarget = target;
      _currentMarker = Marker(
        markerId: const MarkerId('me'),
        position: target,
      );
    });
    await _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: 15),
      ),
    );
  }

  Future<void> _enableLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }
    await _ensurePermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _mapsSupported
          ? ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SizedBox(height: 4),
                const Text(
                  'Choose your location',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Let's find your unforgettable event. Choose a location below to get started.",
                  style: TextStyle(color: Colors.black54),
                ),
          const SizedBox(height: 20),
          // Search field
          TextField(
            decoration: InputDecoration(
              hintText: 'Search location',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: const Color(0xFFF3F5F7),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Set Location on Map button (outline style)
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/choose_location');
            },
            icon: const Icon(Icons.location_on_outlined, color: Colors.green),
            label: const Text('Set Location on Map'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.green,
              side: const BorderSide(color: Colors.green),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Current Location', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          // Map (Android/iOS) or placeholder (desktop)
          SizedBox(
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _mapsSupported
                  ? GoogleMap(
                      initialCameraPosition: CameraPosition(target: _cameraTarget, zoom: 12),
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      markers: {
                        if (_currentMarker != null) _currentMarker!,
                      },
                      onMapCreated: (c) => _mapController = c,
                    )
                  : Container(
                      color: const Color(0xFFE7F0EA),
                      alignment: Alignment.center,
                      child: const Text('Map not supported on this platform',
                          style: TextStyle(color: Colors.black54)),
                    ),
            ),
          ),
          const SizedBox(height: 28),
          // Use Current Location button
          ElevatedButton(
            onPressed: _useCurrentLocation,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4E6E50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Use Current Location'),
          ),
        ],
      )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Choose your location',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Location features are limited on this platform. Choose an option below.',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _enableLocation,
                    icon: const Icon(Icons.my_location),
                    label: const Text('Enable Location'),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pushReplacementNamed(context, '/choose_location'),
                    icon: const Icon(Icons.location_on_outlined, color: Colors.green),
                    label: const Text('Select Location on Map'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green,
                      side: const BorderSide(color: Colors.green),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
