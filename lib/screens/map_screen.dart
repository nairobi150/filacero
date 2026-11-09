import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:filacero/core/app_strings.dart';

class _Station {
  final String name;
  final LatLng position;
  final Color color;
  const _Station(this.name, this.position, this.color);
}

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  static const _laPaz = LatLng(-16.5100, -68.1250);

  // Surtidores ficticios, solo de ejemplo para la demo
  static const _stations = [
    _Station(
      'Surtidor Plaza Villarroel',
      LatLng(-16.5083, -68.1264),
      Colors.green,
    ),
    _Station('Surtidor Sopocachi', LatLng(-16.5120, -68.1310), Colors.amber),
    _Station('Surtidor Miraflores', LatLng(-16.5000, -68.1180), Colors.red),
    _Station('Surtidor Villa Fátima', LatLng(-16.4960, -68.1220), Colors.green),
    _Station('Surtidor Obrajes', LatLng(-16.5260, -68.1010), Colors.grey),
    _Station('Surtidor Calacoto', LatLng(-16.5400, -68.0830), Colors.amber),
  ];

  void _onReportPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.lock_outline, size: 32),
        title: const Text(AppStrings.loginRequiredTitle),
        content: const Text(AppStrings.loginRequiredMessage),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text(AppStrings.ok),
          ),
        ],
      ),
    );
  }

  void _showStation(BuildContext context, _Station s) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s.name)));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.mapTitle),
        backgroundColor: scheme.primaryContainer,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(initialCenter: _laPaz, initialZoom: 13),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.filacero',
              ),
              MarkerLayer(
                markers: [
                  for (final s in _stations)
                    Marker(
                      point: s.position,
                      width: 44,
                      height: 44,
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        onTap: () => _showStation(context, s),
                        child: Icon(
                          Icons.location_on,
                          color: s.color,
                          size: 44,
                        ),
                      ),
                    ),
                ],
              ),
              const SimpleAttributionWidget(source: Text(AppStrings.mapCredit)),
            ],
          ),
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Row(
                  children: [
                    Icon(Icons.visibility_outlined),
                    SizedBox(width: 10),
                    Expanded(child: Text(AppStrings.visitorBanner)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _onReportPressed(context),
        icon: const Icon(Icons.add_location_alt),
        label: const Text(AppStrings.report),
      ),
    );
  }
}
