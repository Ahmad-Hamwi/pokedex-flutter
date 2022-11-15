import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokedex/domain/interactor/get_favourites_count_usecase.dart';

part 'favourites_count_event.dart';

part 'favourites_count_state.dart';

class FavouritesCountBloc
    extends Bloc<FavouritesCountEvent, FavouritesCountState> {
  final GetFavouritesCountUseCase _getFavouritesCountUseCase;

  FavouritesCountBloc(this._getFavouritesCountUseCase)
      : super(FavouritesCountInitial()) {
    on<GetFavouritesCountEvent>((event, emit) async {
      try {
        final count = await _getFavouritesCountUseCase.execute();

        emit(FavouritesCountLoaded(count));
      } catch (e) {
        late int count;
        if (state is FavouritesCountLoaded) {
          count = (state as FavouritesCountLoaded).count;
        }
        emit(FavouritesCountError(count, e));
      }
    });

    add(GetFavouritesCountEvent());
  }
}
