part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeGetImageIdsEvent extends HomeEvent {
  final List<int> categoryIds;

  HomeGetImageIdsEvent(this.categoryIds);

  @override
  List<Object?> get props => [this.categoryIds];
}

class HomeGetImagesEvent extends HomeEvent {


  HomeGetImagesEvent();

  @override
  List<Object?> get props => [];
}
