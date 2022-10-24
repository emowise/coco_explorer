import 'package:cat_coco_explorer/config/get_it.dart';
import 'package:cat_coco_explorer/config/routes.dart';
import 'package:cat_coco_explorer/domain/repositories/coco_repository.dart';
import 'package:cat_coco_explorer/domain/use_cases/image_ids_usecase.dart';
import 'package:cat_coco_explorer/domain/use_cases/query_layers_usecase.dart';
import 'package:cat_coco_explorer/presentation/screens/home/home_bloc.dart';
import 'package:cat_coco_explorer/presentation/screens/home/home_screen.dart';
import 'package:cat_coco_explorer/presentation/screens/splash/splash_bloc.dart';
import 'package:cat_coco_explorer/presentation/screens/splash/splash_screen.dart';
import 'package:cat_coco_explorer/resources/providers/images_pagination.dart';
import 'package:cat_coco_explorer/resources/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();

  runApp(MultiProvider(
    providers: [
      InheritedProvider<CategoriesProvider>(
          create: (_) => CategoriesProvider()),
      InheritedProvider<ImagePagination>(
        create: (_) => ImagePagination(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc(getIt<CocoRepository>())),
        BlocProvider(
            create: (_) => HomeBloc(
                ImageIdUseCase(getIt<CocoRepository>()),
                QueryLayersUseCase(getIt<CocoRepository>()),
                Provider.of<ImagePagination>(context)))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coco Explorer',
        initialRoute: Routes.splashScreen,
        routes: {
          Routes.homeScreen:(_)=>HomeScreen(),
          Routes.splashScreen: (_)=>SplashScreen()
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }

}
