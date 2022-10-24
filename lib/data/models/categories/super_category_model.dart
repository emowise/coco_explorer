import 'categories.dart';

class SuperCategory{
  final String categoryName;
  final List<Category> subCategories;

  SuperCategory(this.categoryName, this.subCategories);

  @override
  String toString() {
    // TODO: implement toString
    return '$categoryName -> ${subCategories.toString()}';
  }

  Map<int, dynamic> subCategoriesToMap()=>{for(var item in subCategories) item.id:item};


}