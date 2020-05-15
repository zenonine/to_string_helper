/// Annotation for class to configure output of [toString()] method.
/// The generated code is a method with name in format [_$classNameToString].
/// For example, generated method for [Bike] class is [String _$bikeToString(Bike o)].
class ToString {
  const ToString({
    this.nullString = 'null',
    this.separator = ', ',
    this.truncate = 0,
    this.onlyPrintValue = false,
  });

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
        'nullString: $nullString'
        ', separator: $separator'
        ', truncate: $truncate'
        ', onlyPrintValue: $onlyPrintValue'
        '}';
  }
}
