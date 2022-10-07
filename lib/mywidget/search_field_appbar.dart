import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/utility.dart';
import '../home/search/search_form_view_controller.dart';
import '../home/search/search_viewcontroller.dart';

class SearchFieldAppbar extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final Function onTaped;
  final String value;
  final String hintText;

  SearchFieldAppbar({Key key, this.onTaped, this.value, this.hintText = 'Rechercher...'}) : super(key: key) {
    controller.text = value;
  }

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
              readOnly: true,
              onTap: onTaped,
              cursorColor: framColor,
              //key: controller.intro.keys[1],
              controller: controller,
              keyboardType: TextInputType.text,
              //onChanged: controller.filterWord,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
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
                hintText: hintText,
                border: InputBorder.none,
                focusColor: framColor,
                hoverColor: framColor,
              ),
            )));
  }
}
