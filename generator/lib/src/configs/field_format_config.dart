class FieldFormatConfig {
  const FieldFormatConfig({
    this.truncate,
    this.unnamedValue,
  });

  final int truncate;
  final bool unnamedValue;

  @override
  String toString() {
    return 'FieldFormatConfig{truncate: $truncate, unnamedValue: $unnamedValue}';
  }
}
