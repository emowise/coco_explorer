import 'dart:convert';

import 'package:cat_coco_explorer/data/models/categories/categories.dart';
import 'package:cat_coco_explorer/domain/entities/category_image_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CategoriesProvider extends ChangeNotifier{
  List<SuperCategory> _categories = <SuperCategory>[];
  Map<int,String> _subCategoriesMap =<int,String>{};

  List<CategoryImageEntity> _categoryImageList=[];

  List<CategoryImageEntity> get categoryImageList=>_categoryImageList;

  set categoryImageList(List<CategoryImageEntity> list){
    _categoryImageList=list;
    notifyListeners();
  }

  List<SuperCategory> get  categories=> _categories;
  Map<int,String> get subCategoriesMap => _subCategoriesMap;


  CategoriesProvider(){
    readCategoriesFromAsset();
    readSubCategoriesFromAsset();
  }

  Future<void> readCategoriesFromAsset() async {
    final String response = await rootBundle.loadString(
        "assets/categories/categories.json");
    Map<String, dynamic> map = json.decode(response);

    List<SuperCategory> list = map.entries.map((e) =>
        SuperCategory(e.key,_subCategories(e.value as List))).toList();
    _categories.addAll(list);

    notifyListeners();

  }

  Future<void> readSubCategoriesFromAsset() async {
    final String response = await rootBundle.loadString(
        "assets/categories/id_to_category.json");
    Map<String, dynamic> map = json.decode(response);
    _subCategoriesMap=Map.fromEntries(map.entries.map((e) => MapEntry(int.parse(e.key), e.value as String)));

    notifyListeners();

  }


  List<Category> _subCategories(List list){
    return list.map((e) => Category.fromJson(e)).toList().cast<Category>();
  }

}