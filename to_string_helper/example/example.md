# Simple example (without code generator)
* `pubspec.yaml`
  ```yaml
  dependencies:
    to_string_helper:
  ```

* `bike.dart`
  ```dart
  import 'package:to_string_helper/to_string_helper.dart';
  
  class Bike {
    final hasEngine = false;
    final wheels = 2;
  
    @override
    String toString() {
      return ToStringHelper(this).add('wheels', wheels).addValue(hasEngine).toString();
    }
  }
  ```

# Simple example (with code generator)
* `pubspec.yaml`
  ```yaml
  dependencies:
    to_string_helper:

  dev_dependencies:
    build_runner:
    to_string_helper_generator:
  ```

* `bike.dart`
  ```dart
  import 'package:to_string_helper/to_string_helper.dart';

  part 'bike.g.dart';

  @ToString()
  class Bike {
    final hasEngine = false;
    final wheels = 2;
  
    @override
    String toString() {
      // Name of the generated method is in format _$<className>ToString()
      return _$bikeToString(this);
    }
  }
  ```