import 'dart:async';
import 'dart:math';

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
import 'package:pokedex/presentation/ui/pages/home/item_pokemon_row.dart';
import 'package:pokedex/presentation/ui/routes/routes.dart';

import '../../../bus/event_bus.dart';
import '../../custom/paged_builder_delegate.dart';

class PokemonList extends StatefulWidget {
  final double width;
  final double height;

  final bool isFavourite;

  const PokemonList({
    Key? key,
    required this.isFavourite,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  late final PokemonsBloc _pokemonsBloc;

  final PagingController<int, List<PokemonEntity>> _pagingController =
      PagingController(firstPageKey: 1);

  late final double width;
  late final double height;

  late final int itemsCountHorizontal;
  late final int itemsCountVertical;

  late final int itemsCount;

  late final StreamSubscription _pokemonFavToggleEventSubscription;

  @override
  void initState() {
    width = widget.width;
    height = widget.height;

    itemsCountHorizontal = (width / 110).floor();
    itemsCountVertical = widget.isFavourite ? 1000 : (height / 186).ceil();

    itemsCount = itemsCountVertical * itemsCountHorizontal;

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

    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _pokemonFavToggleEventSubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // setState(() {
    //   width = MediaQuery.of(context).size.width;
    //   height = MediaQuery.of(context).size.height;
    // });
    // _removePageRequestListener();
    // final currentBlocState = _pokemonsBloc.state;
    // if (currentBlocState is PokemonsLoaded) {
    //   final page = PageEntity(_pagingController.nextPageKey! - 1,
    //       currentBlocState.pokemonPage.totalPages, _pagingController.itemList!);
    //   _refresh();
    //   _appendPage(page);
    // }
    // _addPageRequestListener();
  }

  @override
  bool get wantKeepAlive => true;

  // void _addPageRequestListener() {
  //
  // }
  //
  // void _removePageRequestListener() {
  //
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (c) => _pokemonsBloc,
      child: BlocConsumer<PokemonsBloc, PokemonsState>(
        listener: (context, state) {
          if (state is PokemonsLoaded) {
            _appendPage(
                _mapPageOfItemsToPageOfListOfPokemons(state.pokemonPage));
          } else if (state is PokemonsError) {
            _pagingController.error = state.error;
          }
        },
        builder: (context, state) {
          return PagedListView<int, List<PokemonEntity>>(
            pagingController: _pagingController,
            padding: const EdgeInsets.only(bottom: 12, top: 12),
            builderDelegate: PagedBuilderDelegate<List<PokemonEntity>>(
                showNoMoreDataMessage: !widget.isFavourite,
                emptyMessage: widget.isFavourite
                    ? "No favourites found. Add you favourite pokemons and find them here!"
                    : null,
                itemBuilder: (context, rowOfItems, index) => ItemPokemonRow(
                      horizontalItemCount: itemsCountHorizontal,
                      pokemons: rowOfItems,
                      onViewDetails:
                          (PokemonEntity pokemon, int positionHorizontal) {
                        Navigator.of(context).pushNamed(Routes.pokemon,
                            arguments: rowOfItems[positionHorizontal].id);
                      },
                    ),
                onRetryOnFail: _retry,
                onRefresh: _refresh),
          );
        },
      ),
    );
  }

  void _appendPage(PageEntity<List<PokemonEntity>> pokemonsPage) {
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

  /// a list of [1, 2, 3, 4, 5, 6, 7, 8] and for example each row can have
  /// 3 items, the result is [[1, 2, 3], [4, 5, 6], [7, 8]]
  PageEntity<List<PokemonEntity>> _mapPageOfItemsToPageOfListOfPokemons(
    PageEntity<PokemonEntity> pageOfItems,
  ) {
    List<List<PokemonEntity>> listOfListOfItems = [];
    final remainder = (pageOfItems.items.length % itemsCountHorizontal);
    final lengthWithoutRemainder = pageOfItems.items.length - remainder;
    for (int i = 0; i < lengthWithoutRemainder; i += itemsCountHorizontal) {
      List<PokemonEntity> list = [];

      for (int j = i; j < i + itemsCountHorizontal; j++) {
        list.add(pageOfItems.items[j]);
      }
      listOfListOfItems.add(list);
    }

    final indexOfRemainderList = pageOfItems.items.length - remainder;

    List<PokemonEntity> list = [];
    for (int j = indexOfRemainderList;
        j < indexOfRemainderList + remainder;
        j++) {
      list.add(pageOfItems.items[j]);
    }
    if (list != []) {
      listOfListOfItems.add(list);
    }

    return PageEntity(
        pageOfItems.pageNumber, pageOfItems.totalPages, listOfListOfItems);
  }
}
