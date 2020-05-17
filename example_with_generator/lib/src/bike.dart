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
  static String _secondName = 'Fischer eBike Next Generation';
  String color = 'red';
  var _engine = 'Fischer';
  int _gears = 7;

  @override
  String toString() {
    return _$fischerEBikeToString(this);
  }
}

@ToString(globalInclude: Include(nullValue: false, static: true))
class TrekEBike extends EBike {
  static String name = 'Trek eBike';
  static String _secondName = 'Trek eBike Next Generation';
  String color = 'black';
  String secondColor;
  var _engine = 'Trek';
  int _gears = 5;

  @override
  String toString() {
    return _$trekEBikeToString(this);
  }
}

@ToString(
    globalInclude: Include(
  nullValue: false,
  nonStatic: false,
  static: true,
  public: false,
  private: true,
))
class GiantEBike extends EBike {
  static String name = 'Giant eBike';
  static String _secondName = 'Giant eBike Next Generation';
  String color = 'black';
  String secondColor;
  var _engine = 'Giant';
  int _gears = 5;
  int _wheelSize;

  @override
  String toString() {
    return _$giantEBikeToString(this);
  }
}
