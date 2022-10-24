part of 'splash_bloc.dart';

@immutable
abstract class SplashState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SplashInitial extends SplashState {}

class SplashProgressState extends SplashState {}

class SplashErrorState extends SplashState{
  final String errorMessage;

  SplashErrorState(this.errorMessage);

  @override
  List<Object?> get props => [this.errorMessage];

}

class SplashGetCategoryImages extends SplashState {
  final List<CategoryImageEntity> images;

  SplashGetCategoryImages(this.images);

  @override
  // TODO: implement props
  List<Object?> get props => [this.images];
}
