import 'package:cat_coco_explorer/domain/entities/category_image_entity.dart';
import 'package:cat_coco_explorer/presentation/screens/home/home_bloc.dart';
import 'package:cat_coco_explorer/presentation/widgets/coco_list_item.dart';
import 'package:cat_coco_explorer/presentation/widgets/info_dialog.dart';
import 'package:cat_coco_explorer/resources/coco_api/query_layers.dart';
import 'package:cat_coco_explorer/resources/extensions/context_extensions.dart';
import 'package:cat_coco_explorer/resources/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/coco_image_item_entity.dart';
import '../../../resources/utils.dart';
import '../../widgets/custom_search_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QueryLayers _queryLayers = QueryLayers([], [], [], [], []);
  final _listScrollController = ScrollController();

  late CategoriesProvider categoryProvider;
  late Map<int, String> subCategories;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _listScrollController.addListener(() {
      if (_listScrollController.position.maxScrollExtent ==
          _listScrollController.offset) {
        context.read<HomeBloc>().add(HomeGetImagesEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoriesProvider>(context);
    subCategories = categoryProvider.subCategoriesMap;
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("An Error occurred. Please try again")));
        }
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("Coco Explorer"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomSearchBar(
                  onClick: (List<int> categoryIds) {
                    context
                        .read<HomeBloc>()
                        .add(HomeGetImageIdsEvent(categoryIds));
                    _queryLayers = QueryLayers([], [], [], [], []);
                  },
                  categories: subCategories,
                  controller: TextEditingController(),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeInitial) {
                        return Center(
                          child: Text("Please search by category"),
                        );
                      }
                      if (state is HomeProgressState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is HomeQueryLayersState) {
                        _queryLayers =
                            _queryLayers.fromOldList(state.queryLayers);
                      }

                      if(state is HomeErrorState){
                        return Center(
                          child: Text("An error occurred"),
                        );
                      }

                      return ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 15,
                            );
                          },
                          controller: _listScrollController,
                          shrinkWrap: true,
                          itemCount: _queryLayers.imageIds.length + 1,
                          itemBuilder: (context, index) {
                            if (index < _queryLayers.imageIds.length) {
                              CocoImageItemEntity cocoImageItem = _queryLayers
                                  .groupByImageId()
                                  .values
                                  .elementAt(index);

                              List<int> categoryIds = Utils.categoryIds(
                                  cocoImageItem.segmentationList);
                              List<CategoryImageEntity> _categoryImages =
                              Utils.filterCategoryImageList(
                                  categoryProvider.categoryImageList,
                                  categoryIds);

                              double imageScaleFactor = Utils.imageScaleFactor(
                                  cocoImageItem.cocoImageSize,
                                  context.imageWidth(32));
                              return CocoListItem(
                                segmentationList: cocoImageItem.segmentationList,
                                cocoImageItem: cocoImageItem,
                                categoryImageList: _categoryImages,
                                onCaptionClick: (selected) {
                                  showDialog(
                                      context: context,
                                      builder: (_c) => InfoDialog(
                                        captionList:
                                        cocoImageItem.captionList,
                                      ));
                                },
                                imageScaleFactor: imageScaleFactor,
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 32),
                                child: Center(child: CircularProgressIndicator()),
                              );
                            }
                          });
                    },
                  ),
                )
              ],
            ),
          )),);
  }
}
