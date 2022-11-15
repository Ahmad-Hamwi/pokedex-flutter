abstract class PokemonsEvent {}

class FetchPokemonsEvent extends PokemonsEvent {
  final int page;
  final int itemsCount;

  final bool isFavourite;

  FetchPokemonsEvent(this.page, this.itemsCount, this.isFavourite);
}