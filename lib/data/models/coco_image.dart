import 'package:cat_coco_explorer/domain/entities/coco_image_entity.dart';

class CocoImage extends CocoImageEntity{
  CocoImage(super.id, super.cocoUrl, super.flickrUrl);

  factory CocoImage.fromJson(Map<String,dynamic> map){
    return CocoImage(int.parse(map["id"].toString()), map["coco_url"], map["flickr_url"]);
  }

}