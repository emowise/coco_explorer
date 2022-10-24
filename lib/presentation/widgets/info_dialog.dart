import 'package:cat_coco_explorer/domain/entities/image_caption_entity.dart';
import 'package:flutter/material.dart';

class InfoDialog extends StatelessWidget {
  final List<ImageCaptionEntity> captionList;

  const InfoDialog({Key? key, this.captionList = const <ImageCaptionEntity>[]})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < captionList.length; i++) ...[
            Text("${i + 1}. ${captionList[i].caption}"),
            Divider(height: 6, thickness: 0, color: Colors.black)
          ]
        ],
      ),
    );
  }
}
