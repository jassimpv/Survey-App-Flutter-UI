import 'package:equatable/equatable.dart';
import 'package:collect/core/extensions/survet_kit/src/steps/identifier/identifier.dart';

abstract class Result extends Equatable {
  final Identifier? id;
  final DateTime startDate;
  final DateTime endDate;

  Result({required this.id, required this.startDate, required this.endDate});
}
