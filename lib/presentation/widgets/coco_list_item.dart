import 'package:cat_coco_explorer/domain/entities/coco_image_item_entity.dart';
import 'package:cat_coco_explorer/domain/entities/image_caption_entity.dart';
import 'package:cat_coco_explorer/presentation/widgets/categories_grid_view.dart';
import 'package:cat_coco_explorer/presentation/widgets/custom_draw_segment.dart';
import 'package:cat_coco_explorer/resources/extensions/context_extensions.dart';
import 'package:cat_coco_explorer/resources/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/category_image_entity.dart';
import '../../domain/entities/image_segmentation_entity.dart';

class CocoListItem extends StatefulWidget {
  final CocoImageItemEntity cocoImageItem;
  final List<CategoryImageEntity> categoryImageList;
  final List<ImageSegmentationEntity> segmentationList;
  final Function(List<ImageCaptionEntity> imageCaptionList) onCaptionClick;
  final double imageScaleFactor;

  const CocoListItem(
      {Key? key,
      required this.cocoImageItem,
      required this.categoryImageList,
      required this.onCaptionClick,
      required this.segmentationList,
      required this.imageScaleFactor})
      : super(key: key);

  @override
  State<CocoListItem> createState() => _CocoListItemState();
}

class _CocoListItemState extends State<CocoListItem> {
  late List<List<Offset>> _offsetList;
  late int gridCrossCount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offsetList = Utils.getAllOffsetsForImage(
        widget.imageScaleFactor, widget.segmentationList);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    gridCrossCount = context.gridHorizontalCount;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CategoriesGridView(
                  images: widget.categoryImageList,
                  gridHorizontalCount: gridCrossCount,
                  onCategoryClick: (CategoryImageEntity categoryImage) {
                    ImageSegmentationEntity segmentationEntity =
                        widget.segmentationList.firstWhere((element) =>
                            element.categoryId == categoryImage.categoryId);
                    setState(() {
                      _offsetList = Utils.getOffsetFromSegmentation(
                          widget.imageScaleFactor, segmentationEntity);
                    });
                  }),
            ),
            SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  widget.onCaptionClick(widget.cocoImageItem.captionList);
                },
                icon: Icon(Icons.info_outline))
          ],
        ),
        SizedBox(
          height: 10,
        ),
        CustomDrawSegment(
          offsetList: _offsetList,
          cocoImageItem: widget.cocoImageItem,
          imageScaleFactor: widget.imageScaleFactor,
        )
      ],
    );
  }
}
