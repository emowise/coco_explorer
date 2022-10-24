import 'package:cat_coco_explorer/data/repositories/coco_repository_impl.dart';
import 'package:cat_coco_explorer/domain/repositories/coco_repository.dart';
import 'package:cat_coco_explorer/resources/providers/categories_provider.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {

  getIt.registerSingleton<CategoriesProvider>(CategoriesProvider());
  getIt.registerSingleton<CocoRepository>(CocoRepositoryImpl());
}