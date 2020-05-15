import 'package:to_string_helper/to_string_helper.dart';

import 'vehicle.dart';

part 'bike.g.dart';

@ToString()
class Bike extends Vehicle {
  final hasEngine = false;
  final wheels = 2;

  @override
  String toString() {
    return _$bikeToString(this);
  }
}
