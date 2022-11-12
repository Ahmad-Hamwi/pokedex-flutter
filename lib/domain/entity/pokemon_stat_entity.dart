import 'entity.dart';

class PokemonStatEntity extends Entity {
  String baseStat;
  num value;

  PokemonStatEntity(int id, this.baseStat, this.value) : super(id);
}
