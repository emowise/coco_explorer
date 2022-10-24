import 'package:cat_coco_explorer/domain/entities/category_entity.dart';

class Category extends CategoryEntity{


  Category( super.id,super.name, super.superCategory);

  factory Category.fromJson(Map<String,dynamic> map){
    return Category(map["id"],map["name"], map["supercategory"]);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "[$name--$id--$superCategory]";
  }

}