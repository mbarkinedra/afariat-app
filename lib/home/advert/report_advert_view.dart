import 'package:afariat/config/app_routing.dart';
import 'package:afariat/home/advert/report_advert_viewcontroller.dart';
import 'package:afariat/networking/json/advert_details_json.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../Common/popup.dart';
import '../../config/Environment.dart';
import '../../config/utility.dart';
import '../../model/advert_option_labels.dart';
import '../../mywidget/advert_card_grid.dart';
import '../../mywidget/custom_button_1.dart';
import '../../mywidget/custom_text_filed.dart';
import '../../mywidget/favorite_icon.dart';
import '../../mywidget/information_widget.dart';
import '../../mywidget/log_in_item.dart';
import '../../networking/json/ref_json.dart';
import '../../persistent_tab_manager.dart';
import '../../storage/AccountInfoStorage.dart';
import '../tap_profile/favorite/favorite_view_controller.dart';
import 'advert_details_viewcontroller.dart';

class ReportAdvertView extends GetWidget<ReportAdvertViewController> {
  ReportAdvertView({Key key}) : super(key: key);
  final numberFormat = NumberFormat("###,##0", Environment.locale);
  AccountInfoStorage accountInfoStorage = Get.find<AccountInfoStorage>();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      // key: controller.key,
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity > 0) {
            Get.back();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                title: const Text(
                  " Signaler cette annonce",
                  style: TextStyle(color: Colors.black87),
                ),
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                    icon: const Icon(
                      //
                      Icons.arrow_back_ios,
                      color: framColor,
                    ),
                    onPressed: () {
                      Get.back();
                    }),
              ),
              Card(
                child: Column(
                  children: [
                    Container(
                      height: 120,
                      width: _size.width,
                      child: controller.advert.defaultPhoto != null
                          ? CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: controller.advert.defaultPhoto,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      const Align(
                                          alignment: Alignment.center,
                                          child: CupertinoActivityIndicator()),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/common/no-image.jpg",
                                fit: BoxFit.fill,
                              ),
                            )
                          : Image.asset(
                              "assets/images/common/no-image.jpg",
                              fit: BoxFit.fill,
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      controller.advert.title,
                      style: TextStyle(fontSize: 16),
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      numberFormat.format(controller.advert.price) +
                          ' ' +
                          Environment.currencySymbol,
                      style: const TextStyle(
                          color: framColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text(
                      'Rapport de signalement',
                      style: TextStyle(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => controller.error.isNotEmpty
                          ? InformationWidget(
                              message: controller.error.value,
                              foregroundColor: Colors.redAccent,
                              iconData: Icons.error,
                            )
                          : const SizedBox(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => controller.isLoadingCategories.isTrue
                          ? const CircularProgressIndicator()
                          : Form(
                              key: controller.reportAbuseFormKey,
                              child: Column(
                                children: [
                                  accountInfoStorage.isLoggedIn()
                                      ? const SizedBox()
                                      : LogInItem(
                                          key: const Key('email'),
                                          textEditingController:
                                              controller.email,
                                          label: "E-mail",
                                          hint: "Votre adresse email",
                                          icon: Icons.email,
                                          validator: controller
                                              .validator.validateEmail,
                                          suffixIcon: IconButton(
                                            icon: const Icon(
                                                Icons.clear_outlined),
                                            onPressed: () {
                                              controller.email.clear();
                                            },
                                          ),
                                          clearText: true,
                                        ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  _buildDropDownAbuseCategories(),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomTextFiled(
                                    maxLines: 5,
                                    maxLength: 65000,
                                    color: framColor,
                                    validator:
                                        controller.validator.validateMessage,
                                    hintText:
                                        "Exemple: Je pense que c'est une fraude. L'annonceur me demande des informations personnelles.",
                                    textEditingController: controller.message,
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Obx(
                                    () => controller.isSending.isTrue
                                        ? const CircularProgressIndicator()
                                        : CustomButton1(
                                            height: 50,
                                            width: _size.width * 0.9,
                                            label: "Envoyer",
                                            icon: Icons.send,
                                            iconcolor: Colors.white,
                                            labcolor: Colors.white,
                                            btcolor: framColor,
                                            function: () async {
                                              controller.validator
                                                  .validationType = false;
                                              if (!controller.reportAbuseFormKey
                                                  .currentState
                                                  .validate()) {
                                                return;
                                              }
                                              controller.validator
                                                  .validationType = true;
                                              await controller.sendReport();
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildDropDownAbuseCategories() {
    return DropdownButtonFormField<RefJson>(
      isExpanded: true,
      // value: logic.kilometrage,
      validator: (RefJson refJson) {
        return controller.validator.validateCategory(refJson);
      },
      decoration:
          const InputDecoration.collapsed(hintText: 'Choisissez le motif'),
      iconSize: 24,
      elevation: 16,
      onChanged: controller.updateSelectedCategory,
      items: controller.abuseCategories.data
          .map<DropdownMenuItem<RefJson>>((RefJson value) {
        return DropdownMenuItem<RefJson>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}
