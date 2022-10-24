import 'package:cat_coco_explorer/domain/entities/category_image_entity.dart';
import 'package:cat_coco_explorer/domain/repositories/coco_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final CocoRepository cocoRepository;

  SplashBloc(this.cocoRepository) : super(SplashInitial()) {
    on<SplashEvent>((event, emit) async {
      if (event is SplashGetCategoryImagesEvent) {
        emit(SplashProgressState());

        try {
          List<CategoryImageEntity> images =
          await cocoRepository.getCategoryImages(event.categoryMap);
          emit(SplashGetCategoryImages(images));

        } on Exception catch (e) {
          emit(SplashErrorState(e.toString()));
        }
      }
    });
  }
}
