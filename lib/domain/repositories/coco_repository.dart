
import 'dart:ui';

import 'package:cat_coco_explorer/data/models/selected_image_size.dart';
import 'package:cat_coco_explorer/domain/entities/category_image_entity.dart';
import 'package:cat_coco_explorer/domain/entities/coco_image_entity.dart';
import 'package:cat_coco_explorer/domain/entities/image_caption_entity.dart';
import 'package:cat_coco_explorer/domain/entities/image_segmentation_entity.dart';

abstract class CocoRepository{
  Future<List<int>> getImageIds(List<int> categoryIds);
  Future<List<CocoImageEntity>> getCocoImages(List<int> imageIds);
  Future<List<ImageCaptionEntity>> getImageCaptions(List<int> imageIds);
  Future<List<ImageSegmentationEntity>> getImageSegmentation(List<int> imageIds);
 // Future<QueryLayers> selectedImagesDetails(List<int> imageIds);
  Future<List<CategoryImageEntity>> getCategoryImages(Map<int,String> categoryMap);
  Future<List<SelectedImageSize>> getImageSizes(List<int> imageIds,List<String> cocoUrlList);

}