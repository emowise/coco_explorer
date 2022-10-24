import 'dart:convert';

import 'package:cat_coco_explorer/domain/entities/image_segmentation_entity.dart';

import '../../resources/utils.dart';

class ImageSegmentation extends ImageSegmentationEntity {
  ImageSegmentation(super.imageId, super.categoryId, super.segmentation);

  factory ImageSegmentation.fromJson(Map<String, dynamic> map) {
    return ImageSegmentation(
        int.parse(map["image_id"].toString()),
        int.parse(map["category_id"].toString()),
          Utils.convertDynamicListListTo<double>((json.decode(map["segmentation"]) as List)));
  }
}
