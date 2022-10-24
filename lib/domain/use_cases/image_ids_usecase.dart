import 'package:cat_coco_explorer/domain/repositories/coco_repository.dart';
import 'package:cat_coco_explorer/resources/use_case.dart';

class ImageIdUseCase extends UseCase<List<int>,List<int>>{
  final CocoRepository cocoRepository;

  ImageIdUseCase(this.cocoRepository);

  @override
  Future<List<int>> call(List<int> categoryIds) async{
    return await cocoRepository.getImageIds(categoryIds);
  }

}