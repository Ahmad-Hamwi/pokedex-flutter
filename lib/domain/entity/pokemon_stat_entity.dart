import 'entity.dart';

class PokemonStatEntity extends Entity {
  String name;
  num baseStat;

  PokemonStatEntity(int id, this.name, this.baseStat) : super(id);
}
