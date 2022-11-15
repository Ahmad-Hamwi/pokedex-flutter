import 'package:flutter/material.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/presentation/ui/pages/home/pokemon_list.dart';
import 'package:pokedex/presentation/ui/pages/home/tab_favourites.dart';
import 'package:pokedex/presentation/ui/resources/colors.dart';

import '../../custom/md2_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: _buildAppBar(),
      body: const _Body(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: colorWhite,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/images/ic_pokeball.png"),
          const SizedBox(width: 8),
          const Text(
            "Pokedex",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: colorTextDark),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final favouritesTabKey = GlobalKey();

    void handleOnFavouriteToggled(PokemonEntity pokemonEntity) {
      (favouritesTabKey.currentWidget as TabFavourites?)
          ?.notifyFavouriteToggled();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 2),
        ColoredBox(
          color: colorWhite,
          child: TabBar(
            controller: _tabController,
            indicator: const MD2Indicator(
              indicatorSize: MD2IndicatorSize.full,
              indicatorHeight: 4.0,
              indicatorColor: colorPrimary,
            ),
            tabs: [
              const Tab(
                child: Text(
                  "All Pokemons",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: colorTextDark),
                ),
              ),
              Tab(child: TabFavourites(key: favouritesTabKey)),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              PokemonList(
                isFavourite: false,
                height: height,
                width: width,
                onFavouriteToggled: handleOnFavouriteToggled,
              ),
              PokemonList(
                isFavourite: true,
                height: height,
                width: width,
                onFavouriteToggled: handleOnFavouriteToggled,
              )
            ],
          ),
        )
      ],
    );
  }
}
