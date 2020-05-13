/// Annotation for a specific field to overwrite configuration in `@ToString()`
class ToStringField {
  const ToStringField({
    this.exclude = false,
    this.truncate,
    this.onlyValue,
  });

  /// Overwrite inclusion configuration in `@ToString()`.
  /// Force to exclude this field if `true`, regardless inclusion configuration in `@ToString()`.
  /// Otherwise, force to include this field, regardless inclusion configuration in `@ToString()`.
  final bool exclude;

  /// No truncate if smaller than or equal zero.
  /// Inherit truncate configuration in `@ToString()` if `null`.
  final int truncate;

  /// Don't print field's name, only print field's value.
  /// Inherit `onlyValue` configuration in `@ToString()` if `null`.
  final bool onlyValue;

  @override
  String toString() {
    return 'ToStringField{exclude: $exclude, truncate: $truncate}';
  }
}
