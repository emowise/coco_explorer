import 'package:cat_coco_explorer/resources/utils.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(List<int> categoryIds) onClick;
  final TextEditingController controller;
  final Map<int,String> categories;

  const CustomSearchBar(
      {Key? key,
      required this.onClick,
      required this.categories,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(
            child: TextFormField(
          controller: controller,
          minLines: 1,
          decoration: InputDecoration(
            hintText: "Search by Categories",
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              enabledBorder: OutlineInputBorder(),
              border: OutlineInputBorder()),
        )),
        SizedBox(
          width: 8,
        ),
        ElevatedButton(onPressed: () {

          if(controller.text.trim().isNotEmpty){

            List<String> selectedCategories=controller.text.trim().toLowerCase().split(",");
            List<int> selectedIds=Utils.filterCategoryIdsForSearch(categories, selectedCategories);
            onClick(selectedIds);
          }


        }, child: Text("search"))
      ],
    );
  }
}
