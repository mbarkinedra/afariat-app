import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/utility.dart';
import '../../networking/json/categories_grouped_json.dart';
import 'category_group_viewcontroller.dart';
import 'category_view.dart';

class CategoryGroupView extends GetWidget<CategoryGroupViewController> {
  const CategoryGroupView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      key: controller.key,
      appBar: AppBar(
        title: const Text(
          " Catégorie",
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
                  controller.selectGroup();
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
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: Text(
                      'Toutes les catégories',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                )),
            _buildGroups(context),
          ],
        ),
      )),
    );
  }

  Widget _buildGroups(BuildContext context) {
    return FutureBuilder(
      builder: (context, AsyncSnapshot<CategoriesGroupedJsonList> snapshot) {
        if (snapshot.hasData) {
          return Expanded(
              child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(thickness: 1),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data.length(),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Expanded(
                      flex: 9,
                      child: InkWell(
                          onTap: () {
                            controller.selectGroup(snapshot.data.data[index]);
                            controller.setFilterCategoryLabel(snapshot.data.data[index].name);
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: SizedBox(
                                height: 20,
                                child: Text(
                                  snapshot.data.data[index].name,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              )))),
                  Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          controller.selectGroup(snapshot.data.data[index]);
                          Get.to(() => const CategoryView());
                        },
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: colorGrey,
                        ),
                      )),
                ],
              );
            },
          ));
        } else {
          return const CircularProgressIndicator();
        }
      },
      future: controller.fetchGroups(),
    );
  }
}
