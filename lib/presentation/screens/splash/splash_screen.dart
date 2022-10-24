import 'package:cat_coco_explorer/domain/entities/category_image_entity.dart';
import 'package:cat_coco_explorer/presentation/widgets/categories_grid_view.dart';
import 'package:cat_coco_explorer/resources/extensions/context_extensions.dart';
import 'package:cat_coco_explorer/resources/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../../config/routes.dart';
import 'splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logger=Logger();
    final categoryProvider=Provider.of<CategoriesProvider>(context);
    final categoryMap = categoryProvider.subCategoriesMap;
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        bloc: context.read<SplashBloc>()
          ..add(SplashGetCategoryImagesEvent(categoryMap)),
        listener: (context, state) {
          if(state is SplashGetCategoryImages){

            Navigator.pushNamed(context, Routes.homeScreen);
            categoryProvider.categoryImageList=state.images;
          }
        },
        builder: (context, state) {
          if (state is SplashProgressState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }


          return Container();
        },
      ),
    );
  }
}
