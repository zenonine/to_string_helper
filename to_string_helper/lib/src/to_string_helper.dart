class ToStringHelper {
  ToStringHelper(
    this.object, {
    this.nullString = 'null',
    this.separator = ', ',
    this.truncate = 0,
    this.omitNullValues = false,
  });

  final Object object;

  final String nullString;

  /// Note that, special char must be escaped manually.
  /// For example, to use `$` as separator:
  /// * invalid: [@ToString(separator = '\$')]
  /// * valid: [@ToString(separator = '\\\$')]
  final String separator;

  /// No truncate if smaller than or equal zero
  final int truncate;

  final bool omitNullValues;

  final _sb = StringBuffer();
  var _firstMember = true;

  _open() {
    _sb.write('${object.runtimeType}{');
  }

  _close() {
    _sb.write('}');
  }

  String _memberToString(String name, dynamic value, {int truncate}) {
    if (_sb.isEmpty) {
      _open();
    }

    if (omitNullValues && value == null) {
      return '';
    }

    var valueString = value?.toString() ?? nullString;

    // consider `null` as empty string when calculate length.
    final length = value == null ? 0 : valueString.length;

    // truncate valueString
    final memberTruncate = truncate ?? this.truncate;
    if (value != null && memberTruncate > 0) {
      final endIndex = length > memberTruncate ? memberTruncate : length;
      valueString = valueString.substring(0, endIndex);
    }

    var separator = this.separator;
    if (_firstMember) {
      separator = '';
      _firstMember = false;
    }

    // ignore left part if name is blank or null
    return name?.trim()?.isEmpty ?? true ? '$separator$valueString' : '$separator$name=$valueString';
  }

  /// Adds a name/value pair to the formatted output in `name=value` format.
  /// If the given name is blank or null, adds an unnamed value to the formatted output.
  ToStringHelper add(String name, dynamic value, {int truncate}) {
    if (object != null) {
      _sb.write(_memberToString(name, value, truncate: truncate));
    }
    return this;
  }

  /// Adds an unnamed value to the formatted output.
  ToStringHelper addValue(dynamic value, {int truncate}) {
    return add(null, value, truncate: truncate);
  }

  /// Returns the formatted `String`.
  @override
  String toString() {
    if (object == null) {
      return nullString;
    }

    _close();
    return _sb.toString();
  }
}
