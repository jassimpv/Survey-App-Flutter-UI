import 'package:collect/utils/colors_utils.dart';
import 'package:collect/utils/textstyle_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:collect/extension/country_list_pick/country_list_pick.dart';
import 'package:collect/extension/country_list_pick/country_selection_theme.dart';
import 'package:collect/extension/country_list_pick/support/code_country.dart';

class MobileNumberView extends StatelessWidget {
  final Function(CountryCode?)? onChanged;
  final String image;
  final String dialname;
  final TextEditingController controller;
  const MobileNumberView({
    super.key,
    required this.onChanged,
    required this.image,
    required this.dialname,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorUtils.borderColor),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: CountryListPick(
                theme: CountryTheme(
                  isShowFlag: true,
                  isShowTitle: false,
                  isShowCode: true,
                  isDownIcon: true,
                  initialSelection: '+62',
                  showEnglishName: true,
                ),
                onChanged: onChanged,
                initialSelection: '+971',
                useUiOverlay: true,
                useSafeArea: false,
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                style: StyleUtils.kTextStyleSize17Weight600(
                  color: Colors.black,
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration.collapsed(
                  hintText: 'enterMobileNumber'.tr,
                  hintStyle: StyleUtils.kTextStyleSize17Weight400(
                    color: ColorUtils.hintTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
