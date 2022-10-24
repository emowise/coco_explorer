import 'package:cat_coco_explorer/domain/entities/category_image_entity.dart';
import 'package:cat_coco_explorer/presentation/widgets/category_image_box.dart';
import 'package:flutter/material.dart';

class CategoriesGridView extends StatelessWidget {
  final Function(CategoryImageEntity selectedCategoryImage) onCategoryClick;
  final List<CategoryImageEntity> images;
  final int gridHorizontalCount;

  const CategoriesGridView(
      {Key? key,
      required this.images,
      required this.gridHorizontalCount,
      required this.onCategoryClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridHorizontalCount),
      itemCount: images.length,
      itemBuilder: (context, index) {
        CategoryImageEntity currentImage = images[index];
        return CategoryImageBox(
            onClick: () {
              onCategoryClick(currentImage);
            },
            categoryImage: currentImage);
      },
    );
  }
}
