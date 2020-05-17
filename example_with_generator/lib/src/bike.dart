import 'package:to_string_helper/to_string_helper.dart';

import 'vehicle.dart';

part 'bike.g.dart';

@ToString()
class Bike extends Vehicle {
  final wheels = 2;
  final hasEngine = false;

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
  ),
)
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

@ToString(inclusion: {EBike: Include()})
class HerculesEBike extends EBike {
  static String name = 'Hercules eBike';
  static String _secondName = 'Hercules eBike Next Generation';
  String color = 'black';
  String secondColor;
  var _engine = 'Hercules';
  int _gears = 5;
  int _wheelSize;

  @override
  String toString() {
    return _$herculesEBikeToString(this);
  }
}

@ToString(inclusion: {EBike: Include(), Bike: Include()})
class Hercules2EBike extends EBike {
  static String name = 'Hercules2 eBike';
  static String _secondName = 'Hercules2 eBike Next Generation';
  String color = 'black';
  String secondColor;
  var _engine = 'Hercules2';
  int _gears = 5;
  int _wheelSize;

  @override
  String toString() {
    return _$hercules2EBikeToString(this);
  }
}

@ToString(inclusion: {Bike: Include(), EBike: Include()})
class Hercules3EBike extends EBike {
  static String name = 'Hercules3 eBike';
  static String _secondName = 'Hercules3 eBike Next Generation';
  String color = 'black';
  String secondColor;
  var _engine = 'Hercules3';
  int _gears = 5;
  int _wheelSize;

  @override
  String toString() {
    return _$hercules3EBikeToString(this);
  }
}

@ToString(
    nullString: 'NULL', separator: '\\\$', truncate: 3, unnamedValue: true)
class MoterraEBike extends EBike {
  String color = 'black';
  String secondColor;

  @override
  String toString() {
    return _$moterraEBikeToString(this);
  }
}

@ToString()
class HaibikeEBike extends EBike {
  static String name = 'Haibike eBike';
  static String _secondName = 'Haibike eBike Next Generation';
  @ToStringField(exclude: true)
  String color = 'black';
  String secondColor;
  @ToStringField()
  var _engine = 'Haibike';
  @ToStringField(exclude: null)
  int _gears = 5;
  int _wheelSize;

  @override
  String toString() {
    return _$haibikeEBikeToString(this);
  }
}

@ToString()
class Haibike2EBike extends EBike {
  static String name = 'Haibike2 eBike';
  static String _secondName = 'Haibike2 eBike Next Generation';
  String color = 'black';
  @ToStringField(includeNullValue: false)
  String secondColor;
  @ToStringField()
  var _engine = 'Haibike2';
  int _gears = 5;
  @ToStringField()
  int _wheelSize;

  @override
  String toString() {
    return _$haibike2EBikeToString(this);
  }
}

@ToString()
class Haibike3EBike extends EBike {
  static String name = 'Haibike3 eBike';
  @ToStringField(truncate: 10)
  static String _secondName = 'Haibike3 eBike Next Generation';
  String color = 'black';
  @ToStringField(truncate: 1)
  String secondColor;
  var _engine = 'Haibike3';
  int _gears = 5;
  int _wheelSize;

  @override
  String toString() {
    return _$haibike3EBikeToString(this);
  }
}

@ToString()
class Haibike4EBike extends EBike {
  static String name = 'Haibike3 eBike';
  static String _secondName = 'Haibike4EBike eBike Next Generation';
  @ToStringField(unnamedValue: true)
  String color = 'black';
  String secondColor;
  var _engine = 'Haibike4EBike';
  int _gears = 5;
  int _wheelSize;

  @override
  String toString() {
    return _$haibike4EBikeToString(this);
  }
}
