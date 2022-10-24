import 'package:cat_coco_explorer/domain/entities/image_caption_entity.dart';

class ImageCaption extends ImageCaptionEntity{
  ImageCaption(super.imageId, super.caption);

  factory ImageCaption.fromJson(Map<String,dynamic> map){
    return ImageCaption(int.parse(map["image_id"].toString()), map["caption"]);
  }
}