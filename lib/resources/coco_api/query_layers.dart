import 'dart:ui';

import 'package:cat_coco_explorer/domain/entities/coco_image_entity.dart';
import 'package:cat_coco_explorer/domain/entities/coco_image_item_entity.dart';
import 'package:cat_coco_explorer/domain/entities/image_caption_entity.dart';
import 'package:cat_coco_explorer/domain/entities/image_segmentation_entity.dart';

import '../../domain/entities/category_image_entity.dart';
import '../../domain/entities/selected_image_size_entity.dart';

class QueryLayers {
  final List<int> imageIds;
  final List<ImageSegmentationEntity> _segmentationList;
  final List<CocoImageEntity> _cocoImageList;
  final List<ImageCaptionEntity> _imageCaptionList;
  final List<SelectedImageSizeEntity> _imageSizeList;



  QueryLayers(this.imageIds, this._segmentationList, this._cocoImageList,
      this._imageCaptionList, this._imageSizeList);

  Map<int, CocoImageItemEntity> groupByImageId() {
    Map<int, CocoImageItemEntity> queryLayersMap = {};
    for (int id in imageIds) {
      List<ImageSegmentationEntity> segmentationList =
          _segmentationList.where((element) => element.imageId == id).toList();
      CocoImageEntity cocoImage =
          _cocoImageList.firstWhere((element) => element.imageId == id);
      List<ImageCaptionEntity> captionList =
          _imageCaptionList.where((element) => element.imageId == id).toList();

      Size imageSize=_imageSizeList.firstWhere((element) => element.imageId==id).imageSize;

      CocoImageItemEntity cocoImageItem =
          CocoImageItemEntity(id, captionList, segmentationList, cocoImage,imageSize);
      queryLayersMap[id] = cocoImageItem;
    }

    return queryLayersMap;
  }

  QueryLayers fromOldList(QueryLayers newList) {
    List<int> imageIds = this.imageIds;
    imageIds..addAll(newList.imageIds);
    List<ImageSegmentationEntity> segmentationList = this._segmentationList;
    segmentationList.addAll(newList._segmentationList);
    List<CocoImageEntity> cocoImageList = this._cocoImageList;
    cocoImageList.addAll(newList._cocoImageList);
    List<ImageCaptionEntity> imageCaptionList = this._imageCaptionList;
    imageCaptionList.addAll(newList._imageCaptionList);

    List<SelectedImageSizeEntity> selectedImageSizeList = this._imageSizeList;
    selectedImageSizeList.addAll(newList._imageSizeList);


    return QueryLayers(
        imageIds, segmentationList, cocoImageList, imageCaptionList,selectedImageSizeList);
  }
}
