/// Annotation for a specific field to overwrite configuration in [@ToString()]
class ToStringField {
  const ToStringField({
    this.exclude = false,
    this.includeNullValue,
    this.truncate,
    this.unnamedValue,
  });

  /// * Overwrite inclusion configuration in [@ToString()].
  /// * Force to exclude this field if [true], regardless inclusion configuration in [@ToString()].
  /// * Otherwise, force to include this field, regardless inclusion configuration in [@ToString()].
  final bool exclude;

  /// * Only take into account if [exclude] is [false].
  /// * Inherit [Include.nullValue] if the given [includeNullValue] is [null].
  final bool includeNullValue;

  /// * No truncate if smaller than or equal zero.
  /// * No truncate if field's value is [null].
  /// * Inherit [truncate] configuration in [@ToString()] if [null].
  final int truncate;

  /// * If [true], output shouldn't include field's name, only include field's value.
  /// * Inherit [unnamedValue] configuration in [@ToString()] if [null].
  final bool unnamedValue;

  @override
  String toString() {
    return 'ToStringField{'
        'exclude: $exclude'
        ', includeNullValue: $includeNullValue'
        ', truncate: $truncate'
        ', unnamedValue: $unnamedValue'
        '}';
  }
}
