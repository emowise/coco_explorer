import 'package:cat_coco_explorer/data/models/categories/category_image.dart';
import 'package:cat_coco_explorer/domain/entities/coco_image_entity.dart';
import 'package:flutter/cupertino.dart';

import '../domain/entities/category_image_entity.dart';
import '../domain/entities/image_segmentation_entity.dart';

class Utils {
  static const double categoryImageSize = 60;

  static List<List<T>> convertDynamicListListTo<T>(List list) {
    return list.map<List<T>>((e) => e.cast<T>()).toList();
  }

  static List<CategoryImageEntity> filterCategoryImageList(
      List<CategoryImageEntity> allCategoriesImages,
      List<int> selectedCategoryIDs) {
    return allCategoriesImages
        .where((element) => selectedCategoryIDs.contains(element.categoryId))
        .toList();
  }

  static List<int> selectedCategoryIdsForImage(
      List<ImageSegmentationEntity> segmentationList) {
    return segmentationList.map((e) => e.categoryId).toList();
  }

  static List<int> filterCategoryIdsForSearch(
      Map<int, String> categories, List<String> inputNames) {
    List<int> filteredCategories = categories.entries
        .where((element) => inputNames.contains(element.value))
        .map((e) => e.key)
        .toList();

    return filteredCategories;
  }

  static double imageScaleFactor(Size realSize, double width) {
    return width / realSize.width;
  }

  static List<String> cocoUrlsFromCocoImageList(
      List<CocoImageEntity> cocoImageList) {
    List<String> urls = [];
    for (CocoImageEntity cocoImage in cocoImageList) {
      urls.add(cocoImage.cocoUrl);
    }

    return urls;
  }

  static Map<int, List<ImageSegmentationEntity>> groupSegmentationByCategory(
      List<ImageSegmentationEntity> segmentationList) {
    Map<int, List<ImageSegmentationEntity>> map = {};

    for (int i = 0; i < segmentationList.length; i++) {
      int categoryId = segmentationList[i].categoryId;
      List<ImageSegmentationEntity> list = segmentationList
          .where((element) => element.categoryId == categoryId)
          .toList();
      map[categoryId] = list;
    }

    return map;
  }

  static List<List<Offset>> getOffsetFromSegmentation(
      double imageScaleFactor, ImageSegmentationEntity segmentation) {
    List<List<Offset>> list = <List<Offset>>[];

    segmentation.segmentation.forEach((element) {
      List<Offset> offsets = offsetListFromList(imageScaleFactor, element);
      list.add(offsets);
    });

    return list;
  }

  static List<List<Offset>> getAllOffsetsForImage(
      double imageScaleFactor, List<ImageSegmentationEntity> segmentationList) {
    List<List<Offset>> offsetList = [];

    segmentationList.forEach((element) {
      offsetList.addAll(getOffsetFromSegmentation(imageScaleFactor, element));
    });
    return offsetList;
  }

  static List<Offset> offsetListFromList(
      double imageScaleFactor, List<double> listPoints) {
    List<Offset> offsetList = <Offset>[];
    for (int i = 0; i < listPoints.length - 1; i += 2) {
      Offset offset = Offset(listPoints[i] * imageScaleFactor,
          listPoints[i + 1] * imageScaleFactor);
      offsetList.add(offset);
    }

    return offsetList;
  }

  static List<int> categoryIds(List<ImageSegmentationEntity> segmentationList) {
    Set categorySet = <int>{};
    segmentationList.forEach((item) {
      categorySet.add(item.categoryId);
    });
    return categorySet.toList().cast<int>();
  }

  static List<CategoryImageEntity> getFilteredCategoryImages(
      List<CategoryImage> categoryImages, List<int> selectedCategoriesIds) {
    return categoryImages
        .where((element) => selectedCategoriesIds
            .cast<String>()
            .contains(element.categoryId.toString()))
        .toList()
        .cast<CategoryImage>();
  }
}
