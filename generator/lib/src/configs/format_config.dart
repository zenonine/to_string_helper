class FormatConfig {
  const FormatConfig({
    this.nullString = 'null',
    this.separator = ', ',
    this.truncate = 0,
    this.unnamedValue = false,
  });

  final String nullString;
  final String separator;
  final int truncate;
  final bool unnamedValue;

  @override
  String toString() {
    return 'FormatConfig{'
        'nullString: $nullString'
        ', separator: $separator'
        ', truncate: $truncate'
        ', unnamedValue: $unnamedValue'
        '}';
  }
}
