import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/di/container.dart';
import 'package:pokedex/presentation/ui/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex/presentation/ui/resources/colors.dart';
import 'package:pokedex/presentation/ui/util/string_utils.dart';
import 'package:pokedex/presentation/ui/widgets/fade_on_scroll.dart';

import 'app_bar_content.dart';
import 'layout_pokemon_properties.dart';
import 'layout_pokemon_stats.dart';

class PokemonPage extends StatefulWidget {
  final int pokemonId;

  const PokemonPage({Key? key, required this.pokemonId}) : super(key: key);

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  late final PokemonBloc _pokemonBloc;

  late final ScrollController _scrollController;

  @override
  void initState() {
    _pokemonBloc = sl<PokemonBlocMap>().getBloc(widget.pokemonId);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokemonBloc, PokemonState>(
      bloc: _pokemonBloc,
      listener: (context, state) {},
      builder: (context, state) {
        state as PokemonLoaded;
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: state.pokemonEntity.isFavourite
                ? colorPrimaryLight
                : colorPrimary,
            onPressed: () => _pokemonBloc
                .add(TogglePokemonFavouriteEvent(state.pokemonEntity)),
            label: AnimatedSwitcher(
              duration: Duration(milliseconds: 1000),
              child: state.pokemonEntity.isFavourite
                  ? Text(
                      "Remove from favourites",
                      style: TextStyle(color: colorPrimary),
                    )
                  : Text(
                      "Mark as favourite",
                      style: TextStyle(color: colorWhite),
                    ),
            ),
          ),
          backgroundColor: colorBackground,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor:
                    typeColorMap[state.pokemonEntity.types![0].name],
                pinned: true,
                leadingWidth: 48,
                leading: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: colorTextDark,
                  ),
                ),
                title: FadeOnScroll(
                  scrollController: _scrollController,
                  zeroOpacityOffset: 150,
                  fullOpacityOffset: 250,
                  child: Text(
                    state.pokemonEntity.name.capitalizeFirstLetter(),
                    style: TextStyle(color: colorTextDark),
                  ),
                ),
                expandedHeight: 266.0,
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      PokemonAppBarContent(pokemonEntity: state.pokemonEntity),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    LayoutPokemonProperties(pokemonEntity: state.pokemonEntity),
                    SizedBox(height: 8),
                    LayoutPokemonStats(pokemonEntity: state.pokemonEntity),
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        color: colorBackground,
                        height: 300),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
