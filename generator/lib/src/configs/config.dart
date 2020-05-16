import 'field_config.dart';
import 'format_config.dart';

class Config {
  const Config({this.format, this.fields});

  final FormatConfig format;
  final Set<FieldConfig> fields;

  @override
  String toString() {
    return 'Config{format: $format, fields: $fields}';
  }
}
