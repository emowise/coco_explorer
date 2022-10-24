import 'package:cat_coco_explorer/resources/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/coco_image_item_entity.dart';

class CustomDrawSegment extends StatefulWidget {
  final List<List<Offset>> offsetList;
  final CocoImageItemEntity cocoImageItem;
  final double imageScaleFactor;

  const CustomDrawSegment({
    Key? key,
    required this.offsetList,
    required this.cocoImageItem, required this.imageScaleFactor,
  }) : super(key: key);

  @override
  State<CustomDrawSegment> createState() => _CustomDrawSegmentState();
}

class _CustomDrawSegmentState extends State<CustomDrawSegment> {

  late List<List<Offset>> _offsetList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _offsetList=widget.offsetList;
  }

  @override
  void didUpdateWidget(covariant CustomDrawSegment oldWidget) {

    if(oldWidget.offsetList!=widget.offsetList){
      _offsetList=widget.offsetList;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {

    return CustomPaint(
      child: Image.network(
        widget.cocoImageItem.cocoImage.cocoUrl,
        fit: BoxFit.fill,
        width: context.imageWidth(32),
        scale: widget.imageScaleFactor,
      ),
      foregroundPainter: _CustomDraw(_offsetList),
    );
  }
}

class _CustomDraw extends CustomPainter {
  final List<List<Offset>> offsetList;

  _CustomDraw(this.offsetList);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    for (List<Offset> offsetListElement in offsetList) {
      for (var i = 0; i < (offsetListElement.length - 1); i++) {
        canvas.drawLine(offsetListElement[i], offsetListElement[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
