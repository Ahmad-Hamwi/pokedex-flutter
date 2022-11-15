import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/di/container.dart';
import 'package:pokedex/presentation/ui/bloc/favourites_count/favourites_count_bloc.dart';

import '../../../bus/event_bus.dart';
import '../../../bus/events.dart';
import '../../resources/colors.dart';

class TabFavourites extends StatefulWidget {
  TabFavourites({Key? key}) : super(key: key);

  @override
  State<TabFavourites> createState() => _TabFavouritesState();
}

class _TabFavouritesState extends State<TabFavourites> {
  final FavouritesCountBloc _favouritesCountBloc = sl<FavouritesCountBloc>();

  late final StreamSubscription _pokemonFavToggleEventSubscription;

  @override
  void initState() {
    _pokemonFavToggleEventSubscription =
        eventBus.on<FavouriteToggledBusEvent>().listen((event) {
      notifyFavouriteToggled();
    });
    super.initState();
  }

  @override
  void dispose() {
    _pokemonFavToggleEventSubscription.cancel();
    super.dispose();
  }

  void notifyFavouriteToggled() {
    _favouritesCountBloc.add(GetFavouritesCountEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavouritesCountBloc>(
      create: (context) => _favouritesCountBloc,
      child: BlocConsumer<FavouritesCountBloc, FavouritesCountState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Favourites",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: colorTextDark,
                ),
              ),
              const SizedBox(width: 4),
              if (state is FavouritesCountLoaded)
                CircleAvatar(
                  backgroundColor: colorPrimary,
                  radius: 10,
                  child: Text(
                    state.count.toString(),
                    style: const TextStyle(fontSize: 12, color: colorWhite),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
