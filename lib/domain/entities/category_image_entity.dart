import 'dart:io';

import 'package:flutter/cupertino.dart';

class CategoryImageEntity{
  final int categoryId;
  final String categoryName;
  final NetworkImage categoryImage;

  CategoryImageEntity(this.categoryId, this.categoryName, this.categoryImage);

}