import 'include.dart';

/// Annotation for class to configure output of `toString()` method.
class ToString {
  const ToString({
    this.globalInclude,
    this.inclusion,
    this.nullString = 'null',
    this.separator = ', ',
    this.truncate = 0,
  });

  final Include globalInclude;

  final Map<Type, Include> inclusion;

  final String nullString;

  /// Note that, special char must be escaped manually.
  /// For example, to use `$` as separator:
  /// * invalid: [@ToString(separator = '\$')]
  /// * valid: [@ToString(separator = '\\\$')]
  final String separator;

  /// No truncate if smaller than or equal zero
  final int truncate;

  @override
  String toString() {
    return 'ToString{'
        'globalInclude: $globalInclude'
        ', inclusion: $inclusion'
        ', nullString: $nullString'
        ', separator: $separator'
        ', truncate: $truncate'
        '}';
  }
}
