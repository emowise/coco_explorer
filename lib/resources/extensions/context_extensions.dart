import 'package:cat_coco_explorer/resources/utils.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext{
  int get  gridHorizontalCount=>((MediaQuery.of(this).size.width)/Utils.categoryImageSize).floor();

  double  imageWidth(int offset) => MediaQuery.of(this).size.width-offset;
}