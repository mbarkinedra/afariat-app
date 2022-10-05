import 'package:afariat/model/filter.dart';
import 'package:afariat/networking/json/ref_json.dart';
import 'package:afariat/remote_widget/price_range_slider_viewcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../config/Environment.dart';
import 'package:get/get.dart';
import '../config/utility.dart';

class PriceRangeSlider extends GetWidget<PriceRangeSliderViewController> {
  final Function onChange;

  const PriceRangeSlider({this.controller, this.onChange, Key key})
      : super(key: key);

  @override
  final PriceRangeSliderViewController controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RefListJson>(
        future: controller.fetchItems(),
        builder: (context, AsyncSnapshot<RefListJson> snapshot) {
          if (snapshot.hasData) {
            return Obx(
              () => Column(children: [
                SfRangeSlider(
                  min: controller.minPriceId.value,
                  max: controller.maxPriceId.value,
                  activeColor: framColor,
                  values: SfRangeValues(Filter.minPrice.value, Filter.maxPrice.value),
                  interval: 1,
                  showTicks: false,
                  showLabels: false,
                  enableTooltip: true,
                  tooltipTextFormatterCallback:
                      (dynamic actualValue, String formattedText) {
                    return controller.items.data[actualValue.toInt() - 1].name +
                        " " +
                        Environment.currencySymbol;
                  },
                  labelFormatterCallback:
                      (dynamic actualValue, String formattedText) {
                    if (actualValue == 1 ||
                        actualValue == controller.items.length) {
                      return controller
                              .items.data[actualValue.toInt() - 1].name +
                          " " +
                          Environment.currencySymbol;
                    }
                    return ' ';
                  },
                  labelPlacement: LabelPlacement.onTicks,
                  onChanged: (newValues) {
                    onChange(newValues);
                    controller.selectedMinPriceValue.value =
                        controller.items.data[newValues.start.toInt() - 1].name;
                    controller.selectedMaxPriceValue.value =
                        controller.items.data[newValues.end.toInt() - 1].name;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(controller.selectedMinPriceValue.value +
                          " " +
                          Environment.currencySymbol),
                      Text(controller.selectedMaxPriceValue.value +
                          " " +
                          Environment.currencySymbol)
                    ],
                  ),
                )
              ]),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
