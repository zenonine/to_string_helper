# to_string_helper
Note: this project is not ready to use yet. It will be released soon.

Flexibly configure output of `toString` method.
You can choose either to use code generator or not.

# Example (without code generator)
1. Add dependency to your `pubspec.yaml`
   ```yaml
   dependencies:
       to_string_helper:
   ```
2. Configure your class
   ```dart
   import 'package:to_string_helper/to_string_helper.dart';

   @ToString()
   class Bike {
     final hasEngine = false;
     final wheels = 2;

     return ToStringHelper(this)
       .add('wheels', wheels) // named value
       .addValue(hasEngine) // unnamed value
       .toString();
   }
   ```
3. Output
   ```
   Bike{wheels=2, false}
   ```

# Example (with code generator)
1. Add dependencies to your `pubspec.yaml`
   ```yaml
   dependencies:
       to_string_helper:
   dev_dependencies:
       build_runner:
       to_string_helper_generator:
   ```
2. Configure your class
   ```dart
   import 'package:to_string_helper/to_string_helper.dart';

   // assume current file is bike.dart, the generated code should be in bike.g.dart
   part 'bike.g.dart';

   @ToString()
   class Bike {/*...*/}
   ```
3. Generate code (see [build_runner](https://pub.dev/packages/build_runner))
    * `pub run build_runner build`: run a single build and exit.
    * `pub run build_runner watch`: continuously run builds as you edit files.
4. Use the generated code to produce output of `toString`
   ```dart
   //...

   @ToString()
   class Bike {
     //...

     @override
     String toString() {
       // Name of the generated method is in format _$<className>ToString()
       return _$bikeToString(this);
     }
   }
   ```
5. Output
   ```
   Bike{wheels=2, false}
   ```

# Configuration
* Formatting output
    * Separator
        * Default is a comma follow with a space: `@ToString(separator: ', ')`
        * Change to use semicolon as separator: `@ToString(separator: '; ')`
    * `null` value
        * Default: `@ToString(nullString: 'null')`
        * Change output of null value to `NULL`: `@ToString(nullString: 'NULL')`
    * Truncate if too long
        * Default: `@ToString(truncate: 0)`. Zero or negative value means no truncate.
        * Configure globally to truncate if the output of fields longer than 100 characters: `@ToString(truncate: 100)`
        * Overwrite global configuration for a specific field to truncate if output of the field is longer than 50 characters:
        ```dart
        @ToString(truncate: 100)
        class Bike {
          @ToStringField(truncate: 50)
          final wheels = 2;
        }
        ```
    * Pretty print
* Include fields from super classes
* Include/exclude private fields
* Include/exclude public fields
* Include/exclude static fields
* Include/exclude non-static fields
* Include/exclude null value fields
* Exclude a specific field
  ```dart
  @ToString()
  class Bike {
    @ToStringField(exclude: true)
    final wheels = 2;
  }
  ```
