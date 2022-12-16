import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/di/container.dart';
import 'package:pokedex/domain/entity/page.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/presentation/bus/events.dart';
import 'package:pokedex/presentation/ui/bloc/pokemons/pokemons_bloc.dart';
import 'package:pokedex/presentation/ui/bloc/pokemons/pokemons_event.dart';
import 'package:pokedex/presentation/ui/bloc/pokemons/pokemons_state.dart';
import 'package:pokedex/presentation/ui/pages/home/item_pokemon.dart';
import 'package:pokedex/presentation/ui/routes/routes.dart';

import '../../../bus/event_bus.dart';
import '../../custom/paged_builder_delegate.dart';

class PokemonList extends StatefulWidget {
  final bool isFavourite;

  const PokemonList({
    Key? key,
    required this.isFavourite,
  }) : super(key: key);

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList>
    with AutomaticKeepAliveClientMixin {
  late final PokemonsBloc _pokemonsBloc;

  final PagingController<int, PokemonEntity> _pagingController =
      PagingController(firstPageKey: 1);

  late int itemsCountHorizontal;
  late int itemsCountVertical;

  late int itemsCount;

  late final StreamSubscription _pokemonFavToggleEventSubscription;

  @override
  void initState() {
    _pokemonsBloc = sl<PokemonsBloc>();

    _pagingController.addPageRequestListener((page) {
      _pokemonsBloc.add(FetchPokemonsEvent(
        page,
        itemsCount,
        widget.isFavourite,
      ));
    });

    _pokemonFavToggleEventSubscription =
        eventBus.on<FavouriteToggledBusEvent>().listen((event) {
      if (widget.isFavourite) {
        _refresh();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    _pokemonFavToggleEventSubscription.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    itemsCountHorizontal = (width / 110).floor();
    itemsCountVertical = widget.isFavourite ? 1000 : (height / 186).ceil();

    itemsCount = itemsCountVertical * itemsCountHorizontal;

    return BlocProvider(
      create: (c) => _pokemonsBloc,
      child: BlocConsumer<PokemonsBloc, PokemonsState>(
        listener: (context, state) {
          if (state is PokemonsLoaded) {
            _appendPage(state.pokemonPage);
          } else if (state is PokemonsError) {
            _pagingController.error = state.error;
          }
        },
        builder: (context, state) {
          return PagedGridView<int, PokemonEntity>(
            physics: const BouncingScrollPhysics(),
            pagingController: _pagingController,
            padding: const EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 110 / 186,
              crossAxisCount: itemsCountHorizontal,
            ),
            showNewPageProgressIndicatorAsGridChild: false,
            showNewPageErrorIndicatorAsGridChild: false,
            builderDelegate: PagedBuilderDelegate<PokemonEntity>(
                showNoMoreDataMessage: !widget.isFavourite,
                emptyMessage: widget.isFavourite
                    ? "No favourites found. Add you favourite pokemons and find them here!"
                    : null,
                itemBuilder: (context, item, index) => ItemPokemon(
                      pokemon: item,
                      onViewDetails: (PokemonEntity pokemon) {
                        Navigator.of(context)
                            .pushNamed(Routes.pokemon, arguments: pokemon.id);
                      },
                    ),
                onRetryOnFail: _retry,
                onRefresh: _refresh),
          );
        },
      ),
    );
  }

  void _appendPage(PageEntity<PokemonEntity> pokemonsPage) {
    if (pokemonsPage.isLastPage) {
      _pagingController.appendLastPage(pokemonsPage.items);
    } else {
      _pagingController.appendPage(
          pokemonsPage.items, pokemonsPage.pageNumber.toInt() + 1);
    }
  }

  void _retry() {
    _pagingController.retryLastFailedRequest();
  }

  void _refresh() {
    _pagingController.refresh();
  }
}
