import 'package:to_string_helper/to_string_helper.dart';

import 'vehicle.dart';

@ToString()
class Bike extends Vehicle {
  @ToStringField(exclude: true)
  final wheels = 2;
}
