/// Annotation for a specific field to overwrite configuration in `@ToString()`
class ToStringField {
  const ToStringField({
    this.exclude = false,
    this.truncate,
    this.unnamedValue,
  });

  /// * Overwrite inclusion configuration in [@ToString()].
  /// * Force to exclude this field if [true], regardless inclusion configuration in [@ToString()].
  /// * Otherwise, force to include this field, regardless inclusion configuration in [@ToString()].
  final bool exclude;

  /// * No truncate if smaller than or equal zero.
  /// * Inherit [truncate] configuration in [@ToString()] if [null].
  final int truncate;

  /// * If [true], output shouldn't include field's name, only include field's value.
  /// * Inherit [unnamedValue] configuration in [@ToString()] if [null].
  final bool unnamedValue;

  @override
  String toString() {
    return 'ToStringField{'
        'exclude: $exclude'
        ', truncate: $truncate'
        ', unnamedValue: $unnamedValue'
        '}';
  }
}
