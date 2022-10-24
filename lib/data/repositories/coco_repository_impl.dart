import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cat_coco_explorer/data/models/coco_image.dart';
import 'package:cat_coco_explorer/data/models/image_caption.dart';
import 'package:cat_coco_explorer/data/models/image_segmentation.dart';
import 'package:cat_coco_explorer/domain/entities/coco_image_entity.dart';
import 'package:cat_coco_explorer/domain/entities/selected_image_size_entity.dart';
import 'package:cat_coco_explorer/domain/repositories/coco_repository.dart';
import 'package:cat_coco_explorer/resources/coco_api/coco_api_call.dart';
import 'package:flutter/cupertino.dart';

import '../models/categories/category_image.dart';
import '../models/selected_image_size.dart';

class CocoRepositoryImpl extends CocoRepository {
  @override
  Future<List<CocoImageEntity>> getCocoImages(List<int> imageIds) async {
    final body = <String, dynamic>{
      "image_ids": imageIds,
      "querytype": "getImages"
    };

    Map<String, dynamic> responseBody = await CocoApiCall.callResponseMap(body);

    return responseBody.values
        .map<CocoImageEntity>((e) => CocoImage.fromJson(e))
        .toList();
  }

  @override
  Future<List<ImageCaption>> getImageCaptions(List<int> imageIds) async {
    final body = <String, dynamic>{
      "image_ids": imageIds,
      "querytype": "getCaptions"
    };

    Map<String, dynamic> responseBody = await CocoApiCall.callResponseMap(body);

    return responseBody.values
        .map<ImageCaption>((e) => ImageCaption.fromJson(e))
        .toList()
        .cast<ImageCaption>();
  }

  @override
  Future<List<ImageSegmentation>> getImageSegmentation(
      List<int> imageIds) async {
    final body = <String, dynamic>{
      "image_ids": imageIds,
      "querytype": "getInstances"
    };

    Map<String, dynamic> responseBody = await CocoApiCall.callResponseMap(body);

    return responseBody.values
        .map<ImageSegmentation>((e) => ImageSegmentation.fromJson(e))
        .toList()
        .cast<ImageSegmentation>();
  }

  @override
  Future<List<int>> getImageIds(List<int> categoryIds) async {
    final body = <String, dynamic>{
      "category_ids": categoryIds,
      "querytype": "getImagesByCats"
    };

    Map<String, dynamic> responseBody = await CocoApiCall.callResponseMap(body);
    return responseBody.values.toList().cast<int>();
  }

  @override
  Future<List<CategoryImage>> getCategoryImages(
      Map<int, String> categoryMap) async {
    List<CategoryImage> images = <CategoryImage>[];
    for (int i = 0; i < categoryMap.length; i++) {
      MapEntry<int, String> currentEntry = categoryMap.entries.toList()[i];
      int id = currentEntry.key;

      images.add(CategoryImage(
        id,
        currentEntry.value,
        NetworkImage("https://cocodataset.org/images/cocoicons/$id.jpg"),
      ));
    }

    return images;
  }

  @override
  Future<List<SelectedImageSize>> getImageSizes(
      List<int> imageIds, List<String> cocoUrlList) async {
    List<SelectedImageSize> imageSizeList = [];

    for (int i = 0; i < cocoUrlList.length; i++) {
      String url = cocoUrlList[i];
      int imageId = imageIds[i];

      var data = await http.readBytes(Uri.parse(url));

      var decodedImage = await decodeImageFromList(data);
      imageSizeList.add(SelectedImageSize(imageId,
          Size(decodedImage.width.toDouble(), decodedImage.height.toDouble())));
    }

    return imageSizeList;
  }
}
