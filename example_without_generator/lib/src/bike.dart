import 'package:to_string_helper/to_string_helper.dart';

import 'vehicle.dart';

class Bike extends Vehicle {
  final hasEngine = false;
  final wheels = 2;

  @override
  String toString() {
    return ToStringHelper(this).add('wheels', wheels).addValue(hasEngine).toString();
  }
}
