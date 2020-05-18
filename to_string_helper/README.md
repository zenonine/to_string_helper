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
   
     @override
     String toString() {
       return ToStringHelper(this)
         .add('wheels', wheels) // named value
         .addValue(hasEngine) // unnamed value
         .toString();
     }
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
    * [Pretty print (TODO)](https://github.com/zenonine/to_string_helper/issues/17)

* Force include/exclude a specific field regardless configuration in `@ToString()`
  ```dart
  @ToString()
  class Bike {
    // force to exclude field wheels
    @ToStringField(exclude: true)
    final wheels = 2;
    
    // force to include field _engine
    @ToStringField()
    final _engine = 'No Engine';
  }
  ```

* Include/exclude field types
    * Example using `globalInclude`
      ```dart
      @ToString(
        globalInclude: Include(
          nullValue: true,
          nonStatic: true,
          static: false,
          public: true,
          private: false,
        ),
      )
      class Bike {/*...*/}
      ```
    * Example using `inclusion`
      ```dart
      @ToString(
        inclusion: {
          Bike: Include(
            nullValue: true,
            nonStatic: true,
            static: false,
            public: true,
            private: false,
          ),
        },
      )
      class Bike {/*...*/}
      ```

* Include/exclude inherited fields from super classes

  By default, only declared fields in the annotated class are included in the output.

  To include non-override inherited fields, you must declare it in `@ToString()`.

  Example:
  ```dart
  class Bike {
    final wheels = 2;
    final hasEngine = false;
    final note = 'Bike';
  }
  
  @ToString()
  class EBike1 extends Bike {
    @override
    final hasEngine = true;
    String color = 'red';

    @override
    String toString() {
      return _$eBike1ToString(this);
    }
  }
  
  @ToString(inclusion: {Bike: Include()})
  class EBike2 extends Bike {
    @override
    final hasEngine = true;
    String color = 'black';
  
    @override
    String toString() {
      return _$eBike2ToString(this);
    }
  }
  
  void main() {
    print(EBike1()); // EBike1{hasEngine=true, color=red}
    print(EBike2()); // EBike2{hasEngine=true, color=black, wheels=2, note=Bike}
  }
  ```

* How do `inclusion` map and `globalInclude` work?
    * `inclusion` map determines which class should be scanned for the output.
      If the current annotated class, ex. `EBike1` in the example above, is not found in `inclusion` map,
      entry `{EBike1: Include()}` is added automatically to the map.
    * If `globalInclude` is not specified, `Include()` instance is created and used automatically.
    * `Include` in `inclusion` map and `globalInclude` are then merged.
      Below is an example how the attribute `nullValue` is merged.
        * If `inclusion[Bike].nullValue == null`, use `globalInclude.nullValue`.
        * If `globalInclude.nullValue == null`, use the fallback value (see [default configuration](#default-configuration)).

# Default configuration
* The 2 examples below are treated equally:
  ```dart
  @ToString()
  class Bike {/*...*/}
  ```

  ```dart
  @ToString(
    globalInclude: Include(),
    inclusion: {Bike: Include()},
    nullString: 'null',
    separator: ', ',
    truncate: 0,
    unnamedValue: false,
  )
  class Bike {/*...*/}
  ```
* `inclusion: {Bike: Include(static: true)}` means inheriting all attributes from `globalInclude`, except `Include.static`.
* `globalInclude: Include(static: true)` means using fallback values for all attributes, except `Include.static`.
* Fallback values of `Include()`:
    * `nullValue`: `true`
    * `nonStatic`: `true`
    * `static`: `false`
    * `public`: `true`
    * `private`: `false`
* `@ToStringField()`, `@ToStringField(exclude: false)` or `@ToStringField(exclude: null)` are treated equally. It means, force to include the field regardless of configuration in `@ToString()`.
* `@ToStringField(exclude: true)`: force to exclude the field regardless of configuration in `@ToString()`.
* `ToStringField.includeNullValue == null` means inheriting `Include.nullValue` from `@ToString()` after merging `globalInclude` and `inclusion`.
* `ToStringField.truncate == null` means inheriting `ToString.truncate`.
* `ToStringField.unnamedValue == null` means inheriting `ToString.unnamedValue`.

# More examples:
* [Example - without code generator](https://github.com/zenonine/to_string_helper/tree/master/example_without_generator)
* [Example - with code generator](https://github.com/zenonine/to_string_helper/tree/master/example_with_generator)
