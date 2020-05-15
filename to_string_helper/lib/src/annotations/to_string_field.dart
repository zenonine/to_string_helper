/// Annotation for a specific field to overwrite configuration in `@ToString()`
class ToStringField {
  const ToStringField({
    this.exclude = false,
    this.truncate,
    this.onlyPrintValue,
  });

  /// * Overwrite inclusion configuration in [@ToString()].
  /// * Force to exclude this field if [true], regardless inclusion configuration in [@ToString()].
  /// * Otherwise, force to include this field, regardless inclusion configuration in [@ToString()].
  final bool exclude;

  /// * No truncate if smaller than or equal zero.
  /// * Inherit [truncate] configuration in [@ToString()] if [null].
  final int truncate;

  /// * Don't print field's name, only print field's value.
  /// * Inherit [onlyPrintValue] configuration in [@ToString()] if [null].
  final bool onlyPrintValue;

  @override
  String toString() {
    return 'ToStringField{'
        'exclude: $exclude'
        ', truncate: $truncate'
        ', onlyPrintValue: $onlyPrintValue'
        '}';
  }
}
