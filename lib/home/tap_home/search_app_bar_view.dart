import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../config/utility.dart';
import 'search_app_bar_viewcontroller.dart';

class SearchAppBarView extends GetWidget<SearchAppBarViewController> {
  const SearchAppBarView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return // Add the app bar to the CustomScrollView.
        SliverAppBar(
      // Provide a standard title.
      title: Column(children: <Widget>[
        Row(children: [
          Expanded(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5)),
                    boxShadow: [
                      BoxShadow(
                        color: colorGrey,
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: GetBuilder<SearchAppBarViewController>(builder: (logic) {
                    return const TextField(
                      cursorColor: framColor,
                      //key: controller.intro.keys[1],
                      //controller: controller.searchWord,
                      keyboardType: TextInputType.text,
                      //onChanged: controller.filterWord,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        /*suffixIcon: logic.searchWord.text
                                            .toString()
                                            .isNotEmpty
                                            ? IconButton(
                                          icon: const Icon(
                                            Icons.clear,
                                          ),
                                          onPressed: () {
                                            /* Clear the search field */
                                            //controller.filterClearSearch();
                                          },
                                        )
                                            : null,*/
                        hintText: 'Rechercher...',
                        border: InputBorder.none,
                        focusColor: framColor,
                        hoverColor: framColor,
                      ),
                    );
                  }),
                )),
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
              // width: _size.width * .1,
              child: InkWell(
            onTap: () {
              //show sort popup
            },
            child: const Icon(
              Icons.more_vert,
              size: 30,
              color: colorGrey,
            ),
          ))
        ]),
      ]),
      leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            //color: framColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }),
      backgroundColor: backmenubackground,
      foregroundColor: framColor,
      // Allows the user to reveal the app bar if they begin scrolling
      // back up the list of items.
      floating: true,
      pinned: false,
      // Display a placeholder widget to visualize the shrinking size.
      //flexibleSpace: Placeholder(),
      // Make the initial height of the SliverAppBar larger than normal.
      expandedHeight: 60,

    );
  }
}
