# Simple example
```dart
import 'package:to_string_helper/to_string_helper.dart';

part 'bike.g.dart';

@ToString()
class Bike {
  final wheels = 2;

  @override
  String toString() {
    // Name of the generated method is in format _$<className>ToString()
    return _$bikeToString(this);
  }
}
```
