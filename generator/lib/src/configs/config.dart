import 'package:to_string_helper/to_string_helper.dart';

import 'field_config.dart';
import 'format_config.dart';

class Config {
  const Config({
    this.format,
    this.globalInclude,
    this.fields,
    this.mixin = false,
  });

  final FormatConfig format;
  final Include globalInclude;
  final Set<FieldConfig> fields;
  final bool mixin;

  @override
  String toString() {
    return 'Config{'
        'format: $format'
        ', globalInclude: $globalInclude'
        ', fields: $fields'
        ', mixin: $mixin'
        '}';
  }
}
