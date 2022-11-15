part of 'favourites_count_bloc.dart';

@immutable
abstract class FavouritesCountState {}

class FavouritesCountInitial extends FavouritesCountState {}

class FavouritesCountLoaded extends FavouritesCountState {
  final int count;

  FavouritesCountLoaded(this.count);
}

class FavouritesCountError extends FavouritesCountState {
  final int? count;
  final dynamic error;

  FavouritesCountError(this.count, this.error);
}
