import 'package:to_string_helper/to_string_helper.dart';

import 'vehicle.dart';

part 'car.g.dart';

@ToStringMixin(
  globalInclude: Include(static: true, nullValue: false),
  unnamedValue: true,
)
class Car extends Vehicle with _$CarToString {
  static String name = 'Car';
  @ToStringField(includeNullValue: true, unnamedValue: false)
  String _engine;
  String color;
  final wheels = 4;
}
