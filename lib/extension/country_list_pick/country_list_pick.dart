import "package:collect/extension/country_list_pick/country_selection_theme.dart";
import "package:collect/extension/country_list_pick/selection_list.dart";
import "package:collect/extension/country_list_pick/support/code_countries_en.dart";
import "package:collect/extension/country_list_pick/support/code_country.dart";
import "package:collect/extension/country_list_pick/support/code_countrys.dart";
import "package:collect/utils/colors_utils.dart";
import "package:collect/utils/textstyle_input.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class CountryListPick extends StatefulWidget {
  const CountryListPick({
    super.key,
    this.onChanged,
    this.initialSelection,
    this.appBar,
    this.pickerBuilder,
    this.countryBuilder,
    this.theme,
    this.useUiOverlay = true,
    this.useSafeArea = false,
  });

  final String? initialSelection;
  final ValueChanged<CountryCode?>? onChanged;
  final PreferredSizeWidget? appBar;
  final Widget Function(BuildContext context, CountryCode? countryCode)?
  pickerBuilder;
  final CountryTheme? theme;
  final Widget Function(BuildContext context, CountryCode countryCode)?
  countryBuilder;
  final bool useUiOverlay;
  final bool useSafeArea;

  @override
  _CountryListPickState createState() {
    final List<Map> jsonList = theme?.showEnglishName ?? true
        ? countriesEnglish
        : codes;

    final List<CountryCode> elements = jsonList
        .map(
          (Map s) => CountryCode(
            name: s["name"],
            code: s["code"],
            dialCode: s["dial_code"],
            flagUri: 'flags/${s['code'].toLowerCase()}.png',
          ),
        )
        .toList();
    return _CountryListPickState(elements);
  }
}

class _CountryListPickState extends State<CountryListPick> {
  _CountryListPickState(this.elements);
  CountryCode? selectedItem;
  List elements = <dynamic>[];

  @override
  void initState() {
    if (widget.initialSelection != null) {
      selectedItem = elements.firstWhere(
        (e) =>
            (e.code.toUpperCase() == widget.initialSelection!.toUpperCase()) ||
            (e.dialCode == widget.initialSelection),
        orElse: () => elements[0] as CountryCode,
      );
    } else {
      selectedItem = elements[0];
    }

    super.initState();
  }

  Future<void> _awaitFromSelectScreen(
    BuildContext context,
    PreferredSizeWidget? appBar,
    CountryTheme? theme,
  ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SelectionList(
          elements,
          selectedItem,
          appBar: AppBar(
            backgroundColor: ColorUtils.themeColor,
            title: Text(
              "selectCountryCode".tr,
              style: StyleUtils.titleText(color: ColorUtils.whiteColor),
            ),
            iconTheme: const IconThemeData(color: ColorUtils.whiteColor),
          ),
          theme: theme,
          countryBuilder: widget.countryBuilder,
          useUiOverlay: widget.useUiOverlay,
          useSafeArea: widget.useSafeArea,
        ),
      ),
    );

    setState(() {
      selectedItem = result ?? selectedItem;
      widget.onChanged!(result ?? selectedItem);
    });
  }

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: () {
      _awaitFromSelectScreen(context, widget.appBar, widget.theme);
    },
    child: widget.pickerBuilder != null
        ? widget.pickerBuilder!(context, selectedItem)
        : Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (widget.theme?.isShowFlag ?? true)
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Image.asset(
                      "assets/${selectedItem!.flagUri!}",
                      width: 32,
                    ),
                  ),
                ),
              if (widget.theme?.isShowCode ?? true)
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      selectedItem.toString(),
                      style: StyleUtils.kTextStyleSize17Weight400(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              if (widget.theme?.isShowTitle ?? true)
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(selectedItem!.toCountryStringOnly()),
                  ),
                ),
              if (widget.theme?.isDownIcon ?? true)
                const Flexible(child: Icon(Icons.keyboard_arrow_down)),
            ],
          ),
  );
}
