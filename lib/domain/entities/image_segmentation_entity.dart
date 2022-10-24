import 'dart:ui';

import '../../resources/utils.dart';

class ImageSegmentationEntity {
  final int imageId;
  final int categoryId;
  final List<List<double>> segmentation;

  ImageSegmentationEntity(this.imageId, this.categoryId, this.segmentation);

  List<List<Offset>> offsetOfSegmentation(double imageScaleFactor) {
    List<List<Offset>> offsetList = <List<Offset>>[];

    segmentation.forEach((List<double> element) {
      List<Offset> list = Utils.offsetListFromList(imageScaleFactor, element);
      offsetList.add(list);
    });

    return offsetList;
  }

}
