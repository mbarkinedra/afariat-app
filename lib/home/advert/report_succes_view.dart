import 'package:afariat/home/advert/report_success_view_controller.dart';

import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportSuccessView extends GetWidget<ReportSuccessViewController> {
  const ReportSuccessView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    controller.message = Get.parameters['message'];
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
              child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            height: size.height * .1,
            width: size.height * .1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.teal,
                  ),
                  height: size.height * .1,
                  width: size.height * .1,
                ),
                const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 40.0,
                ),
              ],
            ),
          )),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Rapport envoyé",
              style: TextStyle(
                  color: Colors.teal,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(5)),
              child: SizedBox(
                height: 320,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.message,
                        style: const TextStyle(
                          color: Color.fromRGBO(2, 48, 2, 1),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Notez bien',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.check,
                            color: Colors.teal,
                            size: 22,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "Toute annonce qui enfreint notre règlement de publication sera automatiquement supprimé.",
                              style: TextStyle(fontSize: 18),
                            ), //text
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.check,
                            color: Colors.teal,
                            size: 22,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "Tout utilisateur qui abuse de nos services sera automatiquement suspendu.",
                              style: TextStyle(fontSize: 18),
                            ), //text
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          CustomButton1(
            height: 50,
            label: "OK",
            btcolor: Colors.teal,
            labcolor: Colors.white,
            iconcolor: Colors.white,
            width: size.width * .7,
            fontWeight: FontWeight.bold,
            icon: Icons.check_circle,
            function: () async {
              Get.back();
              Get.back();
            },
          ),
        ],
      ),
    ));
  }
}
