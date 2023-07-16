import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex/presentation/ui/bloc/favourites_count/favourites_count_bloc.dart';

import '../../../mocks/domain/usecase/usecases_mocks_registry.mocks.dart';

void main() {
  late MockGetFavouritesCountUseCase mockCount;

  late FavouritesCountBloc bloc;

  setUp(() {
    mockCount = MockGetFavouritesCountUseCase();

    bloc = FavouritesCountBloc(mockCount);
  });

  group("FavouritesCountBloc", () {
    test("Emits initial state when first created", () {
      expect(bloc.state, isA<FavouritesCountInitial>());
    });

    test(
      "Emits Loaded state in happy scenario when GetFavouritesCountEvent is added",
      () {
        when(mockCount.execute()).thenAnswer((_) async => 5);

        bloc.add(GetFavouritesCountEvent());

        expect(
          bloc.stream,
          emits(
            isA<FavouritesCountLoaded>()
                .having((state) => state.count, "count", 5),
          ),
        );
      },
    );

    test(
      "Emits error state in an error scenario when GetFavouritesCountEvent is added for the first time",
      () {
        when(mockCount.execute()).thenThrow(Exception());

        bloc.add(GetFavouritesCountEvent());

        expect(
          bloc.stream,
          emits(
            isA<FavouritesCountError>()
                .having((state) => state.count, "count", null),
          ),
        );
      },
    );

    test(
      "Emits error state in an error scenario when GetFavouritesCountEvent is added for the second time after an initial successful value",
      () async {
        when(mockCount.execute()).thenAnswer((_) async => 5);
        bloc.add(GetFavouritesCountEvent());

        // awaiting so that we assert first then change the behavior of the mock afterwards
        await expectLater(
          bloc.stream,
          emits(isA<FavouritesCountLoaded>()
              .having((state) => state.count, "count", 5)),
        );

        when(mockCount.execute()).thenThrow(Exception());
        bloc.add(GetFavouritesCountEvent());

        expect(
          bloc.stream,
          emits(
            isA<FavouritesCountError>()
                .having((state) => state.count, "count", 5),
          ),
        );
      },
    );
  });
}
