import 'package:bloc/bloc.dart';
import 'package:cat_coco_explorer/domain/use_cases/image_ids_usecase.dart';
import 'package:cat_coco_explorer/resources/coco_api/query_layers.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/use_cases/query_layers_usecase.dart';
import '../../../resources/providers/images_pagination.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ImageIdUseCase imageIdsUseCase;
  final ImagePagination imagePagination;
  final QueryLayersUseCase queryLayersUseCase;

  HomeBloc(this.imageIdsUseCase, this.queryLayersUseCase, this.imagePagination)
      : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeGetImageIdsEvent) {
        emit(HomeProgressState());

        try {
          List<int> imageIDs = await imageIdsUseCase.call(event.categoryIds);
          imagePagination.imageIds = imageIDs;
          add(HomeGetImagesEvent());
        } on Exception catch (e) {
          emit(HomeErrorState(e.toString()));
        }
      }

      if (event is HomeGetImagesEvent) {
        if (imagePagination.pageCount == 0) {
          emit(HomeProgressState());
        }
        try {
          QueryLayers queryLAyers =
              await queryLayersUseCase.call(imagePagination.queryImageIds());

          emit(HomeQueryLayersState(queryLAyers));
        } on Exception catch (e) {
          emit(HomeErrorState(e.toString()));
        }
      }
    });
  }
}
