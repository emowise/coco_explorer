part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable{
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeImageIdsState extends HomeState{
  final List<int> imageIDs;

  HomeImageIdsState(this.imageIDs);
  @override
  List<Object?> get props => [this.imageIDs];
}

class HomeErrorState extends HomeState{
  final String errorMessage;

  HomeErrorState(this.errorMessage);
  @override
  List<Object?> get props => [this.errorMessage];
}

class HomeQueryLayersState extends HomeState{
  final QueryLayers queryLayers;

  HomeQueryLayersState(this.queryLayers);
  @override
  List<Object?> get props => [this.queryLayers];
}

class HomeProgressState extends HomeState{}
