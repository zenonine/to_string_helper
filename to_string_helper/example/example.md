# Simple example (without code generator)
* `pubspec.yaml`
  ```yaml
  dependencies:
    to_string_helper: ^1.0.0
  ```

* `bike.dart`
  ```dart
  import 'package:to_string_helper/to_string_helper.dart';
  
  class Bike {
    final hasEngine = false;
    final wheels = 2;
  
    @override
    String toString() {
      return ToStringHelper(this)
        .add('wheels', wheels) // named value
        .addValue(hasEngine) // unnamed value
        .toString();
    }
  }
  ```

# Simple example (with code generator)
* Require package [to_string_helper_generator](https://pub.dev/packages/to_string_helper_generator)
* `pubspec.yaml`
  ```yaml
  dependencies:
    to_string_helper: ^1.0.0

  dev_dependencies:
    build_runner: ^1.0.0
    to_string_helper_generator: ^1.0.0
  ```
* `bike.dart` with mixin
  ```dart
  import 'package:to_string_helper/to_string_helper.dart';

  part 'bike.g.dart';

  // Name of the generated mixin is in format _$<ClassName>ToString  
  @ToStringMixin()
  class Bike with _$BikeToString {
    final hasEngine = false;

    @ToStringField(exclude: true)
    final wheels = 2;
  }
  ```
* `bike.dart` without mixin
  ```dart
  import 'package:to_string_helper/to_string_helper.dart';

  part 'bike.g.dart';

  @ToString()
  class Bike {
    final hasEngine = false;

    @ToStringField(exclude: true)
    final wheels = 2;
  
    @override
    String toString() {
      // Name of the generated method is in format _$<className>ToString()
      return _$bikeToString(this);
    }
  }
  ```
