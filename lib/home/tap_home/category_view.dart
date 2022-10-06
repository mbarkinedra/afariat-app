import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/utility.dart';
import '../../networking/json/categories_grouped_json.dart';
import 'category_group_viewcontroller.dart';

class CategoryView extends GetWidget<CategoryGroupViewController> {
  const CategoryView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      //key: controller.keyCat,
      appBar: AppBar(
        title: const Text(
          "Catégorie",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(
              //
              Icons.arrow_back_ios,
              color: framColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 0, right: 16, left: 16),
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  controller.selectGroup(controller.selectedGroup);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1.5, color: Colors.grey[300]),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: Text(
                      controller.selectedGroup.name,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                )),
            _buildCategories(context),
          ],
        ),
      )),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: controller.selectedGroup.subcategories.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              controller.selectCategory(controller.selectedGroup.subcategories[index]);
              //first pop category
              Navigator.pop(context);
              //second pop group
              Navigator.pop(context);
            },
            child: ListTile(
              title: Text(controller.selectedGroup.subcategories[index].name),
            ));
      },
    ));
  }
}
