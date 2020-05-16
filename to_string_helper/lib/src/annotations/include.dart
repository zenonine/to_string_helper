class Include {
  const Include({
    this.nullValue,
    this.nonStatic,
    this.static,
    this.public,
    this.private,
  });

  /// * If [null], inherit from [globalInclude.nullValue].
  /// * If [globalInclude?.nullValue] is also [null], fallback to [nullValue: true].
  final bool nullValue;

  /// * If [null], inherit from [globalInclude.nonStatic].
  /// * If [globalInclude?.nonStatic] is also [null], fallback to [nonStatic: true].
  final bool nonStatic;

  /// * If [null], inherit from [globalInclude.static].
  /// * If [globalInclude?.static] is also [null], fallback to [static: false].
  final bool static;

  /// * If [null], inherit from [globalInclude.public].
  /// * If [globalInclude?.public] is also [null], fallback to [public: true].
  final bool public;

  /// * If [null], inherit from [globalInclude.private].
  /// * If [globalInclude?.private] is also [null], fallback to [private: false].
  final bool private;

  @override
  String toString() {
    return 'Include{'
        'nullValue: $nullValue'
        ', nonStatic: $nonStatic'
        ', static: $static'
        ', public: $public'
        ', private: $private'
        '}';
  }
}
