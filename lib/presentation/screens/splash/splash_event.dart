part of 'splash_bloc.dart';

@immutable
abstract class SplashEvent extends Equatable {
  @override

  List<Object?> get props => [];
}

class SplashGetCategoryImagesEvent extends SplashEvent{
  final Map<int,String> categoryMap;

  SplashGetCategoryImagesEvent(this.categoryMap);
  @override
  List<Object?> get props => [this.categoryMap];
}
