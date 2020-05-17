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

@ToString()
class EBike extends Bike {
  static String name;
  final hasEngine = true;
  String color;
  String _engine;

  @override
  String toString() {
    return _$eBikeToString(this);
  }
}

@ToString()
class FischerEBike extends EBike {
  static String name = 'Fischer eBike';
  String color = 'red';
  var _engine = 'Fischer';

  @override
  String toString() {
    return _$fischerEBikeToString(this);
  }
}
