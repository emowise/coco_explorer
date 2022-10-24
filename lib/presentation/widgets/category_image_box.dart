import 'package:flutter/material.dart';

import '../../domain/entities/category_image_entity.dart';

class CategoryImageBox extends StatelessWidget {
  final VoidCallback onClick;
  final CategoryImageEntity categoryImage;
  final Size size;

  const CategoryImageBox({Key? key, required this.onClick, required this.categoryImage,  this.size=const Size(50,50)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Image(
        width: size.width,
        height: size.height,
        image: categoryImage.categoryImage,
      ),
    );
  }
}
