import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'tap1viewcontroller.dart';

class Tap1Scr extends GetWidget<Tap1ViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                "Home",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.filter_alt_outlined,
                  size: 30,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
