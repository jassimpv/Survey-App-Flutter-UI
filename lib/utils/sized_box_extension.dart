// lib/sized_box_extension.dart

import 'package:flutter/widgets.dart';

extension SizedBoxExtension on num {
  Widget get widthBox => SizedBox(width: toDouble());

  Widget get heightBox => SizedBox(height: toDouble());

  Widget get box => SizedBox(width: toDouble(), height: toDouble());

  Widget widthBoxWithHeight([double? height]) =>
      SizedBox(width: toDouble(), height: height);

  Widget heightBoxWithWidth([double? width]) =>
      SizedBox(height: toDouble(), width: width);
}
