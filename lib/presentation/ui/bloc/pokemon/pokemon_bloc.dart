import 'package:bloc/bloc.dart';
import 'package:pokedex/domain/entity/pokemon_entity.dart';
import 'package:pokedex/domain/interactor/toggle_pokemon_favourite.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final TogglePokemonFavouriteUseCase _toggleFavUseCase;

  PokemonBloc(this._toggleFavUseCase, PokemonEntity pokemonEntity)
      : super(PokemonLoaded(pokemonEntity)) {
    on<TogglePokemonFavouriteEvent>((event, emit) async {
      try {
        final toggledPokemon =
            await _toggleFavUseCase.execute(event.pokemonToBeToggled);

        emit(PokemonFavToggledState(toggledPokemon));
      } catch (e) {
        emit(PokemonErrorFavToggleState(event.pokemonToBeToggled, e));
      }
    });

    on<UpdatePokemonEvent>((event, emit) {
      emit(PokemonLoaded(event.pokemonEntity));
    });
  }
}

class PokemonBlocMap {
  final Map<int, PokemonBloc> _blocMap = {};

  PokemonBlocMap();

  PokemonBloc getBloc(int id, {PokemonBloc Function()? defaultBlocBuilder}) {
    final cachedBloc = _blocMap[id];
    if (cachedBloc == null) {
      final newBloc = _blocMap.putIfAbsent(id, defaultBlocBuilder!);
      return newBloc;
    } else {
      return cachedBloc;
    }
  }

  void setBloc(int id, PokemonBloc newBloc) {
    final cachedBloc = _blocMap[id];

    if (cachedBloc != null) {
      cachedBloc.add(UpdatePokemonEvent(
          (cachedBloc.state as PokemonLoaded).pokemonEntity));
      return;
    }

    _blocMap.putIfAbsent(id, () => newBloc);

    return;
  }

  void dispose() {
    _blocMap.forEach((key, value) {
      value.close();
    });
  }
}
