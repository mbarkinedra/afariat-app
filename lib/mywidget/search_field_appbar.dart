import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/utility.dart';

class SearchFieldAppbar extends StatelessWidget {
  final TextEditingController controller;

  SearchFieldAppbar({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
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
            child: TextField(
              cursorColor: framColor,
              //key: controller.intro.keys[1],
              controller: controller,
              keyboardType: TextInputType.text,
              //onChanged: controller.filterWord,
              decoration: const InputDecoration(
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
            )));
  }
}
