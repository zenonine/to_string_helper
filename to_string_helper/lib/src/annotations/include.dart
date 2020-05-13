class Include {
  const Include({
    this.nullValue,
    this.nonStatic,
    this.static,
    this.public,
    this.private,
  });

  final bool nullValue;
  final bool nonStatic;
  final bool static;
  final bool public;
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
