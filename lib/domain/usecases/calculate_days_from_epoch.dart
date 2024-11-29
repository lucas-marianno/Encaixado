import 'package:encaixado/domain/constants.dart';

/// Calculates the number of elapsed days since day 0 (app first web release)
class CalculateDaysFromAppEpochUsecase {
  int call() => DateTime.now().difference(DateTime.parse(kAppEpoch)).inDays;
}
