import "package:collect/core/extensions/country_list_pick/country_list_pick.dart";
import "package:collect/core/extensions/country_list_pick/country_selection_theme.dart";
import "package:collect/core/extensions/country_list_pick/support/code_country.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/textstyle_input.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";

class MobileNumberView extends StatelessWidget {
  const MobileNumberView({
    required this.onChanged,
    required this.image,
    required this.dialname,
    required this.controller,
    super.key,
  });
  final Function(CountryCode?)? onChanged;
  final String image;
  final String dialname;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: ThemeColors.borderColor),
    ),
    child: IntrinsicHeight(
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {},
            child: CountryListPick(
              theme: CountryTheme(
                isShowFlag: true,
                isShowTitle: false,
                isShowCode: true,
                isDownIcon: true,
                initialSelection: "+62",
                showEnglishName: true,
              ),
              onChanged: onChanged,
              initialSelection: "+971",
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: StyleUtils.kTextStyleSize17Weight600(color: Colors.black),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration.collapsed(
                hintText: "enterMobileNumber".tr,
                hintStyle: StyleUtils.kTextStyleSize17Weight400(
                  color: ThemeColors.hintTextColor,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
