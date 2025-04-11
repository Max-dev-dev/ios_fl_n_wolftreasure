import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:ios_fl_n_wolftreasury_3369/models/wolf_place_model.dart';
import 'package:logger/logger.dart';

class WolfPlaceCubit extends Cubit<WolfPlaceState> {
  WolfPlaceCubit() : super(const WolfPlaceState());

  Future<void> loadPlaces() async {
    emit(state.copyWith(isLoading: true));
    try {
      final jsonString = await rootBundle.loadString(
        'assets/wolf_live_places.json',
      );
      final jsonMap = json.decode(jsonString);
      final placesJson = jsonMap['wolf_places']['items'] as List<dynamic>;
      final places =
          placesJson
              .map((e) => WolfPlace.fromJson(e as Map<String, dynamic>))
              .toList();
      emit(state.copyWith(places: places, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  void toggleFavourite(WolfPlace place) {
    final isFav = state.favourites.any((item) => item.id == place.id);
    Logger().i(
      'Toggling favourite: ${place.title} (${place.id}) | Is favourite: $isFav',
    );

    final updated = List<WolfPlace>.from(state.favourites);

    if (isFav) {
      updated.removeWhere((item) => item.id == place.id);
    } else {
      updated.add(place);
    }

    Logger().i('Updated favourites count: ${updated.length}');
    emit(state.copyWith(favourites: updated));
  }

  bool isFavourite(WolfPlace place) {
    return state.favourites.contains(place);
  }
}

class WolfPlaceState extends Equatable {
  final List<WolfPlace> places;
  final List<WolfPlace> favourites;
  final bool isLoading;

  const WolfPlaceState({
    this.places = const [],
    this.favourites = const [],
    this.isLoading = false,
  });

  WolfPlaceState copyWith({
    List<WolfPlace>? places,
    List<WolfPlace>? favourites,
    bool? isLoading,
  }) {
    return WolfPlaceState(
      places: places ?? this.places,
      favourites: favourites ?? this.favourites,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [places, favourites, isLoading];
}
