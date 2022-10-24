import 'dart:ui';

import 'package:cat_coco_explorer/domain/entities/coco_image_entity.dart';
import 'package:cat_coco_explorer/domain/entities/image_caption_entity.dart';
import 'package:cat_coco_explorer/domain/entities/image_segmentation_entity.dart';

class CocoImageItemEntity{
  final int imageId;
  final List<ImageCaptionEntity> captionList;
  final List<ImageSegmentationEntity> segmentationList;
  final CocoImageEntity cocoImage;
  final Size cocoImageSize;

  CocoImageItemEntity(this.imageId, this.captionList, this.segmentationList, this.cocoImage, this.cocoImageSize);


}