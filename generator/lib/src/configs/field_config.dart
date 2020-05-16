import 'package:analyzer/dart/element/element.dart';
import 'package:to_string_helper/to_string_helper.dart';

import 'field_format_config.dart';

class FieldConfig {
  const FieldConfig(this.id,
      {this.field, this.exclude = false, this.include, this.format});

  final String id;
  final FieldElement field;
  final bool exclude;
  final Include include;
  final FieldFormatConfig format;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FieldConfig &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'FieldConfig{'
        'id: $id'
        ', field: $field'
        ', exclude: $exclude'
        ', include: $include'
        ', format: $format'
        '}';
  }
}
