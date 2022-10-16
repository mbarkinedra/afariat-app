import 'package:afariat/config/Environment.dart';
import 'package:afariat/config/utility.dart';
import 'package:afariat/model/type_register.dart';
import 'package:afariat/mywidget/custom_button_1.dart';
import 'package:afariat/mywidget/log_in_item.dart';
import 'package:afariat/sign_up/sign_up_viewcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../remote_widget/city_dropdown_src.dart';

class SignUpScr extends GetWidget<SignUpViewController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            // Provide a standard title.
            flexibleSpace: Container(
              width: _size.width,
              height: 150,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [
                    Color(0xFFFFCCBC),
                    Colors.white,
                  ],
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: framColor,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                        const Expanded(
                          flex: 8,
                          child: Text(
                            'Création de compte',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            automaticallyImplyLeading: false,

            backgroundColor: backmenubackground,
            foregroundColor: framColor,
            floating: true,
            pinned: false,
            expandedHeight: 100,
            elevation: 0,
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: _buildFormScreen(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildFormScreen(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Form(
      key: controller.registerFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Align(
            alignment: Alignment.center,
            child: Text(
              "C'est GRATUIT !",
              style: TextStyle(color: Colors.grey.shade400, fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: _size.height * .01,
          ),
          Text(
            "Toutes vos annonces et vos favoris à un seul endroit.",
            style: TextStyle(color: Colors.grey.shade800),
          ),
          SizedBox(
            height: _size.height * .03,
          ),
          Obx(
            () => controller.globalErrors.isNotEmpty
                ? Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.warning_rounded,
                          color: Colors.redAccent,
                        ),
                      ),
                      Text(
                        controller.globalErrors.value,
                        style: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  )
                : SizedBox(),
          ),
          SizedBox(
            height: _size.height * .03,
          ),
          GetBuilder<SignUpViewController>(builder: (logic) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Vous êtes ?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black38, width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 3, bottom: 0, left: 10, right: 10),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<TypeRegister>(
                          key: const Key('type'),
                          hint: const Text("Type"),
                          isExpanded: true,
                          value: logic.type,
                          iconSize: 24,
                          elevation: 16,
                          onChanged: logic.updateTypeRegister,
                          items: logic.typeList
                              .map<DropdownMenuItem<TypeRegister>>(
                                  (TypeRegister value) {
                            return DropdownMenuItem<TypeRegister>(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
          SizedBox(
            height: _size.height * .02,
          ),
          LogInItem(
            key: const Key('firstName'),
            textEditingController: controller.firstName,
            label: "Prénom",
            hint: "Votre prénom ou nom de la société",
            icon: Icons.account_circle,
            validator: controller.validator.validateFirstName,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear_outlined),
              onPressed: () {
                controller.firstName.clear();
              },
            ),
            clearText: true,
          ),
          SizedBox(
            height: _size.height * .02,
          ),
          LogInItem(
            key: Key('lastName'),
            textEditingController: controller.lastName,
            label: "Nom",
            hint: "Votre Nom",
            icon: Icons.account_circle,
            validator: controller.validator.validateLastName,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear_outlined),
              onPressed: () {
                controller.lastName.clear();
              },
            ),
            clearText: true,
          ),
          SizedBox(
            height: _size.height * .02,
          ),
          LogInItem(
            key: Key('phone'),
            textEditingController: controller.phone,
            label: "N° de Téléphone",
            hint: Environment.phonePlaceholder,
            icon: Icons.add_call,
            validator: controller.validator.validatePhone,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear_outlined),
              onPressed: () {
                controller.phone.clear();
              },
            ),
            clearText: true,
          ),
          SizedBox(
            height: _size.height * .02,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  flex: 3,
                  child: Text(
                    'Localisation',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black38, width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 3, bottom: 0, left: 10, right: 10),
                      child: Container(
                        //margin: const EdgeInsets.only(bottom: 10.0),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black38,
                              width: 0.75,
                            ),
                          ),
                        ),
                        child: CityDropdown(
                          controller.cityDropdownViewController,
                          validator: controller.validator.validateCity,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
          SizedBox(
            height: _size.height * .02,
          ),
          LogInItem(
            key: Key('email'),
            textEditingController: controller.email,
            label: "E-mail",
            hint: "Votre adresse email",
            icon: Icons.email,
            validator: controller.validator.validateEmail,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear_outlined),
              onPressed: () {
                controller.email.clear();
              },
            ),
            clearText: true,
          ),
          SizedBox(
            height: _size.height * .02,
          ),
          GetBuilder<SignUpViewController>(builder: (logic) {
            return LogInItem(
              validator: controller.validator.validatePassword,
              label: "Mot de passe",
              hint: "**********",
              icon: Icons.lock_outline,
              //Ajouter
              obscureText: logic.isVisiblePassword,
              textEditingController: controller.password,
              suffixIcon: IconButton(
                onPressed: controller.showHidePassword,
                icon: Icon(logic.isVisiblePassword
                    ? Icons.visibility_off
                    : Icons.visibility),
              ),
            );
          }),
          SizedBox(
            height: _size.height * .05,
          ),
          Center(
            child: Obx(
              () => controller.isLoading.isTrue
                  ? const CircularProgressIndicator()
                  : CustomButton1(
                      height: 50,
                      width: _size.width * .8,
                      btcolor: buttonColor,
                      icon: Icons.login,
                      iconcolor: Colors.white,
                      label: "Créer mon compte",
                      labcolor: textbuttonColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      function: () {
                        controller.validator.validationType = false;
                        if (!controller.registerFormKey.currentState
                            .validate()) {
                          return;
                        }
                        controller.validator.validationType = true;
                        //send data to server and get errors
                        controller.postRegister(context);
                      },
                    ),
            ),
          ),
          SizedBox(
            height: _size.height * .05,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: RichText(
                text: const TextSpan(
                  text: "Vous avez déjà un compte ? ",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Log in',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: framColor,
                          fontSize: 18),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: _size.height * .2,
          )
        ],
      ),
    );
  }
}
