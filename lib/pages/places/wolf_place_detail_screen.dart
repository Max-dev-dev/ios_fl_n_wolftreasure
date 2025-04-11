import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ios_fl_n_wolftreasury_3369/models/wolf_place_model.dart';
import 'package:ios_fl_n_wolftreasury_3369/cubit/wolf_place_cubit.dart';
import 'package:share_plus/share_plus.dart';

class WolfPlaceDetailScreen extends StatefulWidget {
  final WolfPlace wolfPlace;
  const WolfPlaceDetailScreen({super.key, required this.wolfPlace});

  @override
  State<WolfPlaceDetailScreen> createState() => _WolfPlaceDetailScreenState();
}

class _WolfPlaceDetailScreenState extends State<WolfPlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _iconButton(Icons.arrow_back, () => Navigator.pop(context)),
                    _labelBox('MAP'),
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          child: Image.asset(
                            widget.wolfPlace.image,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.wolfPlace.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                widget.wolfPlace.description,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.locationDot,
                                    size: 26,
                                    color: Color(0xFFB4773A),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Coordinates:\n ${widget.wolfPlace.latitude.toStringAsFixed(4)}° N,\n${widget.wolfPlace.longitude.toStringAsFixed(4)}° W',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFB4773A),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Container(
                    width: 220,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BlocBuilder<WolfPlaceCubit, WolfPlaceState>(
                          builder: (context, state) {
                            final isFavourite = state.favourites.any(
                              (item) => item.id == widget.wolfPlace.id,
                            );

                            return _bottomAction(
                              isFavourite
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              () {
                                context.read<WolfPlaceCubit>().toggleFavourite(
                                  widget.wolfPlace,
                                );
                              },
                            );
                          },
                        ),
                        _bottomAction(Icons.share, () {
                          Share.share(
                            "🌍 Explore this wolf place: ${widget.wolfPlace.title}\n\n${widget.wolfPlace.description}\n\n📍 ${widget.wolfPlace.latitude}, ${widget.wolfPlace.longitude}",
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback action) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFB4773A),
          borderRadius: BorderRadius.circular(20),
        ),
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

  Widget _bottomAction(IconData icon, VoidCallback action) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFB4773A),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
