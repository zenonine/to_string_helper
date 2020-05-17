import 'include.dart';

/// Annotation for class to configure output of [toString()] method.
/// The generated code is a method with name in format [_$classNameToString].
/// For example, generated method for [Bike] class is [String _$bikeToString(Bike o)].
class ToString {
  const ToString({
    this.globalInclude,
    this.inclusion,
    this.nullString = 'null',
    this.separator = ', ',
    this.truncate = 0,
    this.unnamedValue = false,
  });

  /// * If [globalInclude?.nullValue] is [null], fallback to [nullValue: true].
  /// * If [globalInclude?.nonStatic] is [null], fallback to [nonStatic: true].
  /// * If [globalInclude?.static] is [null], fallback to [static: false].
  /// * If [globalInclude?.public] is [null], fallback to [public: true].
  /// * If [globalInclude?.private] is [null], fallback to [private: false].
  final Include globalInclude;

  final Map<Type, Include> inclusion;

  final String nullString;

  /// Note that, special char must be escaped manually.
  /// For example, to use [$] as separator:
  /// * invalid: [@ToString(separator = '\$')]
  /// * valid: [@ToString(separator = '\\\$')]
  final String separator;

  /// * No truncate if smaller than or equal zero.
  /// * No truncate if field's value is [null].
  final int truncate;

  /// If [true], output shouldn't include field's name, only include field's value.
  final bool unnamedValue;

  @override
  String toString() {
    return 'ToString{'
        'globalInclude: $globalInclude'
        ', inclusion: $inclusion'
        'nullString: $nullString'
        ', separator: $separator'
        ', truncate: $truncate'
        ', unnamedValue: $unnamedValue'
        '}';
  }
}
