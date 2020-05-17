# to_string_helper
Flexibly configure output of `toString` method (with or without code generation).

You can choose either to use code generator or not.

If you want to generate code, you also need the package
[to_string_helper_generator](https://pub.dev/packages/to_string_helper_generator).
Otherwise, you only need this package.

# Example (without code generator)
1. Add dependency to your `pubspec.yaml`
   ```yaml
   dependencies:
       to_string_helper: ^1.0.0
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
       to_string_helper: ^1.0.0
   dev_dependencies:
       build_runner: ^1.0.0
       to_string_helper_generator: ^1.0.0
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
5. Output
   ```
   Bike{wheels=2, hasEngine=false}
   ```

# Configuration for code generator
* Formatting output
    * Separator
        * Default is a comma follow with a space: `@ToString(separator: ', ')`
        * Change to use semicolon as separator: `@ToString(separator: '; ')`
    * `null` value
        * Default: `@ToString(nullString: 'null')`
        * Change output of null value to `NULL`: `@ToString(nullString: 'NULL')`
    * Named and unnamed value
        * Named value: `Bike{wheels=2}`.
        * Unnamed value: `Bike{2}`.
        * Default: `@ToString(unnamedValue: false)`.
        * If `unnamedValue` is `true`, unnamed value should be used. Otherwise, use named value.
        * Overwrite the global configuration for a specific field:
          ```dart
          @ToString(unnamedValue: false)
          class Bike {
            @ToStringField(unnamedValue: true)
            final wheels = 2;
          }
          ```
    * Truncate if too long
        * Default: `@ToString(truncate: 0)`. Zero or negative value means no truncate.
        * Configure globally to truncate if the output of fields longer than 100 characters: `@ToString(truncate: 100)`
        * Overwrite the global configuration for a specific field to truncate
          if output of the field is longer than 50 characters:
          ```dart
          @ToString(truncate: 100)
          class Bike {
            @ToStringField(truncate: 50)
            final wheels = 2;
          }
          ```
    * Pretty print (TODO)
* Exclude a specific field
  ```dart
  @ToString()
  class Bike {
    @ToStringField(exclude: true)
    final wheels = 2;
  }
  ```
* Include/exclude fields from super classes (TODO)
* Include/exclude private fields (TODO)
* Include/exclude public fields (TODO)
* Include/exclude static fields (TODO)
* Include/exclude non-static fields (TODO)
* Include/exclude null value fields (TODO)
