import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ios_fl_n_wolftreasury_3369/cubit/wolf_place_cubit.dart';
import 'package:ios_fl_n_wolftreasury_3369/models/wolf_place_model.dart';
import 'package:ios_fl_n_wolftreasury_3369/pages/places/wolf_place_detail_screen.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';

class WildExplorerMap extends StatefulWidget {
  final String? startCoordinates;
  const WildExplorerMap({super.key, this.startCoordinates});

  @override
  State<WildExplorerMap> createState() => _WildExplorerMapState();
}

class _WildExplorerMapState extends State<WildExplorerMap> {
  final MapController _controller = MapController();
  WolfPlace? highlightedPlace;
  bool isInfoVisible = false;
  double zoomLevel = 4.0;

  @override
  void initState() {
    super.initState();
    context.read<WolfPlaceCubit>().loadPlaces();

    if (widget.startCoordinates != null) {
      final LatLng? point = _interpretCoordinates(widget.startCoordinates!);
      if (point != null) {
        Future.microtask(() => _controller.move(point, 14));
      }
    }
  }

  LatLng? _interpretCoordinates(String coords) {
    try {
      final parts = coords.split(',');
      if (parts.length != 2) return null;
      final lat = double.parse(parts[0].trim());
      final lng = double.parse(parts[1].trim());
      final result = LatLng(lat, lng);
      Logger().i('Parsed LatLng: $result');
      return result;
    } catch (e) {
      Logger().e('Invalid coordinate format: $coords', error: e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _actionButton(Icons.arrow_back, () => Navigator.pop(context)),
                  _labelBox('MAP'),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<WolfPlaceCubit, WolfPlaceState>(
                builder: (context, state) {
                  final markerWidgets =
                      state.places.map((place) {
                        return Marker(
                          point: LatLng(place.latitude, place.longitude),
                          width: 40,
                          height: 40,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                highlightedPlace = place;
                                isInfoVisible = true;
                                _controller.move(
                                  LatLng(place.latitude, place.longitude),
                                  14,
                                );
                              });
                            },
                            child: const Icon(
                              Icons.place,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        );
                      }).toList();

                  return Stack(
                    children: [
                      FlutterMap(
                        mapController: _controller,
                        options: MapOptions(
                          initialCenter: LatLng(39.8283, -98.5795),
                          initialZoom: zoomLevel,
                          minZoom: 2,
                          maxZoom: 18,
                          interactionOptions: const InteractionOptions(
                            flags: InteractiveFlag.all,
                          ),
                          onTap:
                              (_, __) => setState(() => isInfoVisible = false),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                            tileBuilder: _darkOverlayTile,
                          ),
                          MarkerLayer(markers: markerWidgets),
                        ],
                      ),
                      if (isInfoVisible && highlightedPlace != null)
                        Positioned(
                          bottom: width > 375 ? 150 : 80,
                          left: 20,
                          right: 20,
                          child: _InfoPanel(
                            location: highlightedPlace!,
                            onClose:
                                () => setState(() => isInfoVisible = false),
                          ),
                        ),
                      Positioned(
                        bottom: width > 375 ? 40 : 80,
                        right: 8,
                        child: Column(
                          children: [
                            _zoomControl(Icons.add, () {
                              setState(
                                () =>
                                    zoomLevel = (zoomLevel + 1).clamp(
                                      2.0,
                                      18.0,
                                    ),
                              );
                              _controller.move(
                                _controller.camera.center,
                                zoomLevel,
                              );
                            }),
                            const SizedBox(height: 10),
                            _zoomControl(Icons.remove, () {
                              setState(
                                () =>
                                    zoomLevel = (zoomLevel - 1).clamp(
                                      2.0,
                                      18.0,
                                    ),
                              );
                              _controller.move(
                                _controller.camera.center,
                                zoomLevel,
                              );
                            }),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _darkOverlayTile(BuildContext context, Widget tile, TileImage img) {
    return ColorFiltered(
      colorFilter: const ColorFilter.matrix([
        -0.2126,
        -0.7152,
        -0.0722,
        0,
        255,
        -0.2126,
        -0.7152,
        -0.0722,
        0,
        255,
        -0.2126,
        -0.7152,
        -0.0722,
        0,
        255,
        0,
        0,
        0,
        1,
        0,
      ]),
      child: tile,
    );
  }

  Widget _zoomControl(IconData icon, VoidCallback callback) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black87,
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: callback,
        icon: Icon(icon, color: Colors.white),
        iconSize: 30,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }

  Widget _actionButton(IconData icon, VoidCallback action) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFB4773A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: action,
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _labelBox(String label) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFB4773A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  final WolfPlace location;
  final VoidCallback onClose;

  const _InfoPanel({required this.location, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF10133A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      location.image,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        location.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 300,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF10133A),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _action(location, Icons.close, onClose),
              _action(location, Icons.share, () {
                Share.share(
                  "🌕 I’ve found a legendary wolf place: ${location.title} 🐺\n\n"
                  "${location.description}\n\n"
                  "Wanna feel the call of the wild?\n📍 ${location.latitude}, ${location.longitude}",
                );
              }),
              _action(location, Icons.arrow_forward, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => WolfPlaceDetailScreen(wolfPlace: location),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _action(WolfPlace place, IconData icon, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFB4773A),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
