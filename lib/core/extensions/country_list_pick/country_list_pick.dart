import "package:collect/core/extensions/country_list_pick/country_selection_theme.dart";
import "package:collect/core/extensions/country_list_pick/support/code_countries_en.dart";
import "package:collect/core/extensions/country_list_pick/support/code_country.dart";
import "package:collect/core/extensions/country_list_pick/support/code_countrys.dart";

import "package:collect/core/theme/theme_colors.dart";
import "package:collect/core/utils/textstyle_input.dart";
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
    final CountryCode? result = await showModalBottomSheet<CountryCode>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.45,
          maxChildSize: 0.95,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            final TextEditingController searchController =
                TextEditingController();

            // cast once to typed list and keep mutable filtered outside the builder so it persists
            final List<CountryCode> allCountries = elements.cast<CountryCode>();
            List<CountryCode> filtered = List<CountryCode>.from(allCountries);

            return StatefulBuilder(
              builder: (BuildContext context, setState) {
                // filtered is declared outside the builder so it survives rebuilds
                // localFilter updates it and we call setState where needed
                void localFilter(String s) {
                  final String q = s.trim().toUpperCase();
                  filtered = allCountries
                      .where(
                        (CountryCode e) =>
                            e.name!.toUpperCase().contains(q) ||
                            (e.dialCode ?? '').contains(q) ||
                            (e.code ?? '').toUpperCase().contains(q),
                      )
                      .toList();
                }

                // After first build, scroll list to selected index once

                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),

                      // show currently selected country at the top
                      if (selectedItem != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Card(
                            elevation: 0,
                            color: Colors.grey.shade50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  "assets/${selectedItem!.flagUri!}",
                                  width: 36,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(selectedItem!.name ?? ''),
                              trailing: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: ThemeColors.themeColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                onChanged: (String v) {
                                  setState(() {
                                    localFilter(v);
                                  });
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search),
                                  hintText: "search".tr,
                                  filled: true,
                                  fillColor: Colors.grey.shade100,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 12,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: ListView.separated(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemBuilder: (BuildContext context, int index) {
                            final CountryCode c = filtered[index];
                            final bool isSelected =
                                c.code == selectedItem!.code;
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  "assets/${c.flagUri!}",
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(c.name ?? ''),
                              subtitle: Text(c.dialCode ?? ''),
                              trailing: isSelected
                                  ? Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: ThemeColors.themeColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    )
                                  : null,
                              onTap: () => Navigator.pop(context, c),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(height: 1),
                          itemCount: filtered.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedItem = result;
        widget.onChanged!(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      _awaitFromSelectScreen(context, widget.appBar, widget.theme);
    },
    child: widget.pickerBuilder != null
        ? widget.pickerBuilder!(context, selectedItem)
        : Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (widget.theme?.isShowFlag ?? true)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Image.asset(
                      "assets/${selectedItem!.flagUri!}",
                      width: 30,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                Text(
                  widget.theme?.isShowCode ?? true
                      ? ' ${selectedItem!.dialCode} '
                      : '',
                  style: StyleUtils.kTextStyleSize16Weight500(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
  );
}
