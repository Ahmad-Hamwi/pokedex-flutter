import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/domain/interactor/get_pokemons_usecase.dart';

import 'pokemons_event.dart';
import 'pokemons_state.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  final GetPokemonsUseCase _getPokemonsUseCase;

  PokemonsBloc(this._getPokemonsUseCase) : super(PokemonsLoading()) {
    on<FetchPokemonsEvent>((event, emit) async {
      try {
        if (state is! PokemonsLoading) {
          emit(PokemonsLoading());
        }

        final pokemons = await _getPokemonsUseCase.execute(
          GetPokemonsUseCaseParams(event.page, event.itemsCount, event.isFavourite),
        );

        emit(PokemonsLoaded(pokemons));
      } catch (e) {
        emit(PokemonsError(e));
      }
    });
  }
}
