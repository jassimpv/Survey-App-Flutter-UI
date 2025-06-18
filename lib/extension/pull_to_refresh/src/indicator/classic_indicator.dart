/*
 *   Author: Jpeng
 *   Email: peng8350@gmail.com
 *   createTime:2018-05-14 17:39
 */

import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:collect/extension/pull_to_refresh/pull_to_refresh_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// direction that icon should place to the text
enum IconPosition { left, right, top, bottom }

/// wrap child in outside,mostly use in add background color and padding
typedef OuterBuilder = Widget Function(Widget child);

class ClassicFooter extends LoadIndicator {
  final String? idleText, loadingText, noDataText, failedText, canLoadingText;

  /// a builder for re wrap child,If you need to change the boxExtent or background,padding etc.you need outerBuilder to reWrap child
  /// example:
  /// ```dart
  /// outerBuilder:(child){
  ///    return Container(
  ///       color:Colors.red,
  ///       child:child
  ///    );
  /// }
  /// ````
  /// In this example,it will help to add backgroundColor in indicator
  final OuterBuilder? outerBuilder;

  final Widget? idleIcon, loadingIcon, noMoreIcon, failedIcon, canLoadingIcon;

  /// icon and text middle margin
  final double spacing;

  final IconPosition iconPos;

  final TextStyle textStyle;

  /// notice that ,this attrs only works for LoadStyle.ShowWhenLoading
  final Duration completeDuration;

  const ClassicFooter({
    super.key,
    super.onClick,
    super.loadStyle,
    super.height,
    this.outerBuilder,
    this.textStyle = const TextStyle(color: Colors.grey),
    this.loadingText,
    this.noDataText,
    this.noMoreIcon,
    this.idleText,
    this.failedText,
    this.canLoadingText,
    this.failedIcon = const Icon(Icons.error, color: Colors.grey),
    this.iconPos = IconPosition.left,
    this.spacing = 15.0,
    this.completeDuration = const Duration(milliseconds: 300),
    this.loadingIcon,
    this.canLoadingIcon = const Icon(Icons.autorenew, color: Colors.grey),
    this.idleIcon = const Icon(Icons.arrow_upward, color: Colors.grey),
  });

  @override
  State<StatefulWidget> createState() {
    return _ClassicFooterState();
  }
}

class _ClassicFooterState extends LoadIndicatorState<ClassicFooter> {
  Widget _buildText(LoadStatus? mode) {
    RefreshString strings =
        RefreshLocalizations.of(context)?.currentLocalization ??
        EnRefreshString();
    return Text(
      mode == LoadStatus.loading
          ? widget.loadingText ?? strings.loadingText!
          : LoadStatus.noMore == mode
          ? widget.noDataText ?? strings.noMoreText!
          : LoadStatus.failed == mode
          ? widget.failedText ?? strings.loadFailedText!
          : LoadStatus.canLoading == mode
          ? widget.canLoadingText ?? strings.canLoadingText!
          : widget.idleText ?? strings.idleLoadingText!,
      style: widget.textStyle,
    );
  }

  Widget _buildIcon(LoadStatus? mode) {
    Widget? icon = mode == LoadStatus.loading
        ? widget.loadingIcon ??
              SizedBox(
                width: 25.0,
                height: 25.0,
                child: defaultTargetPlatform == TargetPlatform.iOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(strokeWidth: 2.0),
              )
        : mode == LoadStatus.noMore
        ? widget.noMoreIcon
        : mode == LoadStatus.failed
        ? widget.failedIcon
        : mode == LoadStatus.canLoading
        ? widget.canLoadingIcon
        : widget.idleIcon;
    return icon ?? Container();
  }

  @override
  Future endLoading() {
    return Future.delayed(widget.completeDuration);
  }

  @override
  Widget buildContent(BuildContext context, LoadStatus? mode) {
    Widget textWidget = _buildText(mode);
    Widget iconWidget = _buildIcon(mode);
    List<Widget> children = <Widget>[iconWidget, textWidget];
    final Widget container = Wrap(
      spacing: widget.spacing,
      textDirection: widget.iconPos == IconPosition.left
          ? TextDirection.ltr
          : TextDirection.rtl,
      direction:
          widget.iconPos == IconPosition.bottom ||
              widget.iconPos == IconPosition.top
          ? Axis.vertical
          : Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      verticalDirection: widget.iconPos == IconPosition.bottom
          ? VerticalDirection.up
          : VerticalDirection.down,
      alignment: WrapAlignment.center,
      children: children,
    );
    return widget.outerBuilder != null
        ? widget.outerBuilder!(container)
        : SizedBox(
            height: widget.height,
            child: Center(child: container),
          );
  }
}
