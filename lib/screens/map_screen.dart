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

  static const _green = Color(0xFF43A047);
  static const _amber = Color(0xFFFFB300);
  static const _red = Color(0xFFE53935);
  static const _grey = Color(0xFF9E9E9E);
  static const _navy = Color(0xFF1B1F3B);

  // Surtidores ficticios, solo de ejemplo para la demo
  static const _stations = [
    _Station('Surtidor Plaza Villarroel', LatLng(-16.5083, -68.1264), _green),
    _Station('Surtidor Sopocachi', LatLng(-16.5120, -68.1310), _amber),
    _Station('Surtidor Miraflores', LatLng(-16.5000, -68.1180), _red),
    _Station('Surtidor Villa Fátima', LatLng(-16.4960, -68.1220), _green),
    _Station('Surtidor Obrajes', LatLng(-16.5260, -68.1010), _grey),
    _Station('Surtidor Calacoto', LatLng(-16.5400, -68.0830), _amber),
  ];

  void _onReportPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        icon: Container(
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            color: Color(0xFFFFE0B2),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.lock_outline,
            size: 32,
            color: Color(0xFFE65100),
          ),
        ),
        title: const Text(
          AppStrings.loginRequiredTitle,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        content: const Text(
          AppStrings.loginRequiredMessage,
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFF4511E),
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            ),
            onPressed: () => Navigator.pop(ctx),
            child: const Text(AppStrings.ok),
          ),
        ],
      ),
    );
  }

  void _showStation(BuildContext context, _Station s) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: _navy,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 90),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        content: Row(
          children: [
            Icon(Icons.local_gas_station, color: s.color),
            const SizedBox(width: 10),
            Expanded(child: Text(s.name)),
          ],
        ),
      ),
    );
  }

  Widget _legendRow(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 12.5)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.mapTitle,
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.5),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFFF9800), Color(0xFFF4511E), Color(0xFFC2185B)],
            ),
          ),
        ),
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
                      width: 46,
                      height: 46,
                      child: GestureDetector(
                        onTap: () => _showStation(context, s),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: s.color, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.local_gas_station,
                            color: s.color,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SimpleAttributionWidget(source: Text(AppStrings.mapCredit)),
            ],
          ),
          // Cartel de modo visitante
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFE0B2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.visibility_outlined,
                        color: Color(0xFFE65100),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        AppStrings.visitorBanner,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Leyenda de colores
          Positioned(
            bottom: 16,
            left: 12,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _legendRow(_green, AppStrings.legendHas),
                    _legendRow(_amber, AppStrings.legendLow),
                    _legendRow(_red, AppStrings.legendNone),
                    _legendRow(_grey, AppStrings.legendNoReports),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFFF4511E),
        foregroundColor: Colors.white,
        elevation: 6,
        onPressed: () => _onReportPressed(context),
        icon: const Icon(Icons.add_location_alt),
        label: const Text(
          AppStrings.report,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
