import 'include.dart';

/// Annotation for class to configure output of [toString()] method.
class ToString {
  const ToString({
    this.globalInclude,
    this.inclusion,
    this.nullString = 'null',
    this.separator = ', ',
    this.truncate = 0,
    this.onlyPrintValue = false,
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

  /// No truncate if smaller than or equal zero.
  final int truncate;

  /// Don't print field's name, only print field's value.
  final bool onlyPrintValue;

  @override
  String toString() {
    return 'ToString{'
        'globalInclude: $globalInclude'
        ', inclusion: $inclusion'
        ', nullString: $nullString'
        ', separator: $separator'
        ', truncate: $truncate'
        ', onlyPrintValue: $onlyPrintValue'
        '}';
  }
}
