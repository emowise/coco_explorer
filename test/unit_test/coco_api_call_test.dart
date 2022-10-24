import 'package:cat_coco_explorer/data/repositories/coco_repository_impl.dart';
import 'package:cat_coco_explorer/domain/repositories/coco_repository.dart';
import 'package:cat_coco_explorer/domain/use_cases/image_ids_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class CocoRepositoryMock extends Mock implements CocoRepository{}
class ImageIdUseCaseMock extends Mock implements ImageIdUseCase{}

void main(){

  CocoRepositoryMock cocoRepositoryMock=CocoRepositoryMock();
  late ImageIdUseCaseMock imageIdUseCaseMock;

  setUp(() {
    imageIdUseCaseMock=ImageIdUseCaseMock();
  });


  group("coco api testing", () async{


  });



}