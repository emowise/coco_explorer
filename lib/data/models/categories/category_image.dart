import 'package:cat_coco_explorer/domain/entities/category_image_entity.dart';

class CategoryImage extends CategoryImageEntity{
  CategoryImage(super.categoryId, super.categoryName, super.categoryImage);

  @override
  String toString() {
    return "${super.categoryId} - ${super.categoryName}";
  }

}