import 'dart:ui';

import 'package:cat_coco_explorer/data/models/selected_image_size.dart';
import 'package:cat_coco_explorer/domain/entities/image_caption_entity.dart';
import 'package:cat_coco_explorer/domain/entities/image_segmentation_entity.dart';
import 'package:cat_coco_explorer/domain/repositories/coco_repository.dart';
import 'package:cat_coco_explorer/resources/coco_api/query_layers.dart';
import 'package:cat_coco_explorer/resources/use_case.dart';
import 'package:cat_coco_explorer/resources/utils.dart';

import '../entities/coco_image_entity.dart';

class QueryLayersUseCase extends UseCase<QueryLayers, List<int>> {
  final CocoRepository cocoRepository;

  QueryLayersUseCase(this.cocoRepository);

  @override
  Future<QueryLayers> call(List<int> imageIds) async {
    var response = await Future.wait([
      cocoRepository.getImageSegmentation(imageIds),
      cocoRepository.getCocoImages(imageIds),
      cocoRepository.getImageCaptions(imageIds)
    ]);

    List<ImageSegmentationEntity> _segmentationList =
        response[0].cast<ImageSegmentationEntity>();
    List<CocoImageEntity> _cocoImageList = response[1].cast<CocoImageEntity>();
    List<ImageCaptionEntity> _imageCaptionList =
        response[2].cast<ImageCaptionEntity>();

    List<String> cocoUrls=Utils.cocoUrlsFromCocoImageList(_cocoImageList);
    List<SelectedImageSize> imageSizes= await cocoRepository.getImageSizes(imageIds,cocoUrls);


    QueryLayers queryLayers = QueryLayers(
        imageIds, _segmentationList, _cocoImageList, _imageCaptionList,imageSizes);

    return queryLayers;
  }
}
