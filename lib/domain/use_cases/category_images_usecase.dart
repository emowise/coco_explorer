import 'package:cat_coco_explorer/domain/entities/category_image_entity.dart';
import 'package:cat_coco_explorer/domain/repositories/coco_repository.dart';
import 'package:cat_coco_explorer/resources/use_case.dart';

class CategoryImagesUseCase
    extends UseCase<List<CategoryImageEntity>, Map<int, String>> {
  final CocoRepository cocoRepository;

  CategoryImagesUseCase(this.cocoRepository);

  @override
  Future<List<CategoryImageEntity>> call(Map<int, String> categoryMap) async {
    return await cocoRepository.getCategoryImages(categoryMap);
  }
}
