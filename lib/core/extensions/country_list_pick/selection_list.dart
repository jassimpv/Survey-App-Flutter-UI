import "package:collect/core/extensions/country_list_pick/country_selection_theme.dart";
import "package:collect/core/extensions/country_list_pick/support/code_country.dart";
import "package:collect/core/theme/theme_colors.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";

class SelectionList extends StatefulWidget {
  const SelectionList(
    this.elements,
    this.initialSelection, {
    super.key,
    this.appBar,
    this.theme,
    this.countryBuilder,
    this.useUiOverlay = true,
    this.useSafeArea = false,
  });

  final PreferredSizeWidget? appBar;
  final List<dynamic> elements;
  final CountryCode? initialSelection;
  final CountryTheme? theme;
  final Widget Function(BuildContext context, CountryCode)? countryBuilder;
  final bool useUiOverlay;
  final bool useSafeArea;

  @override
  SelectionListState createState() => SelectionListState();
}

class SelectionListState extends State<SelectionList> {
  late List<dynamic> countries;
  final TextEditingController _controller = TextEditingController();
  ScrollController? _controllerScroll;
  double diff = 0;

  int posSelected = 0;
  double height = 0;
  late double sizeheightcontainer;
  late double heightscroller;
  String? text;
  String? oldtext;
  final double _itemsizeheight = 50;
  double _offsetContainer = 0;

  bool isShow = true;

  @override
  void initState() {
    countries = widget.elements;
    countries.sort((a, b) => a.name.toString().compareTo(b.name.toString()));
    _controllerScroll = ScrollController();
    _controllerScroll!.addListener(_scrollListener);
    super.initState();
  }

  void _sendDataBack(BuildContext context, CountryCode initialSelection) {
    Navigator.pop(context, initialSelection);
  }

  final List<String> _alphabet = List<String>.generate(
    26,
    (int i) => String.fromCharCode("A".codeUnitAt(0) + i),
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ThemeColors.whiteColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: ThemeColors.whiteColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: !kIsWeb ? Brightness.dark : Brightness.light,
      ),
    );

    height = MediaQuery.of(context).size.height;
    final Widget scaffold = Scaffold(
      appBar: widget.appBar,
      body: ColoredBox(
        color: ThemeColors.whiteColor.withValues(alpha: 0.96),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints contrainsts) {
            diff = height - contrainsts.biggest.height;
            heightscroller = (contrainsts.biggest.height) / _alphabet.length;
            sizeheightcontainer = contrainsts.biggest.height;
            return Stack(
              children: <Widget>[
                CustomScrollView(
                  controller: _controllerScroll,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ColoredBox(
                            color: ThemeColors.whiteColor,
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                ),
                                hintText: "${'search'.tr}...",
                              ),
                              onChanged: _filterElements,
                            ),
                          ),
                          ColoredBox(
                            color: ThemeColors.whiteColor,
                            child: Material(
                              color: Colors.transparent,
                              child: ListTile(
                                leading: Image.asset(
                                  "assets/${widget.initialSelection!.flagUri!}",
                                  width: 32,
                                ),
                                title: Text(widget.initialSelection!.name!),
                                trailing: const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.check,
                                    color: ThemeColors.statusGreen,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) =>
                            widget.countryBuilder != null
                            ? widget.countryBuilder!(
                                context,
                                countries.elementAt(index),
                              )
                            : getListCountry(countries.elementAt(index)),
                        childCount: countries.length,
                      ),
                    ),
                  ],
                ),
                if (isShow)
                  Align(
                    alignment: Get.locale!.countryCode != "AE"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: GestureDetector(
                      onVerticalDragUpdate: _onVerticalDragUpdate,
                      onVerticalDragStart: _onVerticalDragStart,
                      child: Container(
                        height: 20.0 * 30,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            ...List.generate(
                              _alphabet.length,
                              _getAlphabetItem,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
    return widget.useSafeArea ? SafeArea(child: scaffold) : scaffold;
  }

  Widget getListCountry(CountryCode e) => Container(
    height: 50,
    color: ThemeColors.whiteColor,
    child: Material(
      color: Colors.transparent,
      child: ListTile(
        leading: Image.asset("assets/${e.flagUri!}", width: 30),
        title: Text(e.name!),
        onTap: () {
          _sendDataBack(context, e);
        },
      ),
    ),
  );

  Expanded _getAlphabetItem(int index) => Expanded(
    child: InkWell(
      onTap: () {
        setState(() {
          posSelected = index;
          text = _alphabet[posSelected];
          if (text != oldtext) {
            for (int i = 0; i < countries.length; i++) {
              if (text.toString().compareTo(
                    countries[i].name.toString().toUpperCase()[0],
                  ) ==
                  0) {
                _controllerScroll!.jumpTo((i * _itemsizeheight) + 10);
                break;
              }
            }
            oldtext = text;
          }
        });
      },
      child: Container(
        width: 40,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: index == posSelected
              ? widget.theme?.alphabetSelectedBackgroundColor ??
                    ThemeColors.primary
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Text(
          _alphabet[index],
          textAlign: TextAlign.center,
          style: (index == posSelected)
              ? TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color:
                      widget.theme?.alphabetSelectedTextColor ?? Colors.white,
                )
              : TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: widget.theme?.alphabetTextColor ?? Colors.black,
                ),
        ),
      ),
    ),
  );

  void _filterElements(String s) {
    s = s.toUpperCase();
    setState(() {
      countries = widget.elements
          .where(
            (e) =>
                e.code.contains(s) ||
                e.dialCode.contains(s) ||
                e.name.toUpperCase().contains(s),
          )
          .toList();
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      if ((_offsetContainer + details.delta.dy) >= 0 &&
          (_offsetContainer + details.delta.dy) <=
              (sizeheightcontainer - heightscroller)) {
        _offsetContainer += details.delta.dy;
        posSelected = ((_offsetContainer / heightscroller) % _alphabet.length)
            .round();
        text = _alphabet[posSelected];
        if (text != oldtext) {
          for (int i = 0; i < countries.length; i++) {
            if (text.toString().compareTo(
                  countries[i].name.toString().toUpperCase()[0],
                ) ==
                0) {
              _controllerScroll!.jumpTo((i * _itemsizeheight) + 15);
              break;
            }
          }
          oldtext = text;
        }
      }
    });
  }

  void _onVerticalDragStart(DragStartDetails details) {
    _offsetContainer = details.globalPosition.dy - diff;
  }

  void _scrollListener() {
    final int scrollPosition =
        (_controllerScroll!.position.pixels / _itemsizeheight).round();
    if (scrollPosition < countries.length) {
      final String? countryName = countries.elementAt(scrollPosition).name;
      setState(() {
        posSelected =
            countryName![0].toUpperCase().codeUnitAt(0) - "A".codeUnitAt(0);
      });
    }

    if ((_controllerScroll!.offset) >=
        (_controllerScroll!.position.maxScrollExtent)) {}
    if (_controllerScroll!.offset <=
            _controllerScroll!.position.minScrollExtent &&
        !_controllerScroll!.position.outOfRange) {}
  }
}
