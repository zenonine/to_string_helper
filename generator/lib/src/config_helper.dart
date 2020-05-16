import 'dart:collection';

import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:to_string_helper/to_string_helper.dart';

import 'configs/config.dart';
import 'configs/field_config.dart';
import 'configs/field_format_config.dart';
import 'configs/format_config.dart';

const defaultFormatConfig = FormatConfig();

Config getConfig(ConstantReader annotation, ClassElement classElement) {
  return Config(
    format: FormatConfig(
      nullString: _peek(annotation, 'nullString')?.stringValue ?? defaultFormatConfig.nullString,
      separator: _peek(annotation, 'separator')?.stringValue ?? defaultFormatConfig.separator,
      truncate: _peek(annotation, 'truncate')?.intValue ?? defaultFormatConfig.truncate,
      unnamedValue: _peek(annotation, 'unnamedValue')?.boolValue ?? defaultFormatConfig.unnamedValue,
    ),
    fields: _getFieldConfigs(classElement),
  );
}

Set<FieldConfig> _getFieldConfigs(ClassElement classElement) {
  final Set<FieldConfig> fieldConfigs = LinkedHashSet();

  for (final fieldElement in classElement.fields) {
    final prefix = fieldElement.isStatic ? '${classElement.name}.' : '';

    final fieldAnnotation = _getFieldAnnotation(fieldElement, ToStringField);

    fieldConfigs.add(FieldConfig(
      '$prefix${fieldElement.name}',
      field: fieldElement,
      exclude: _peek(fieldAnnotation, 'exclude')?.boolValue ?? false,
      format: FieldFormatConfig(
        truncate: _peek(fieldAnnotation, 'truncate')?.intValue,
        unnamedValue: _peek(fieldAnnotation, 'unnamedValue')?.boolValue,
      ),
    ));
  }

  return LinkedHashSet.of(fieldConfigs.where((fc) => _isIncludedField(fc)));
}

bool _isIncludedField(FieldConfig fc) {
  if (fc.exclude) {
    return false;
  }

  return true;
}

ConstantReader _peek(ConstantReader cr, String field) {
  final reader = cr?.peek(field);

  if (reader?.isNull ?? false) {
    return null;
  }

  return reader;
}

ConstantReader _getFieldAnnotation(FieldElement element, Type annotationType) {
  final typeChecker = TypeChecker.fromRuntime(annotationType);
  var annotation = typeChecker.firstAnnotationOf(element);
  if (annotation == null && element.getter != null) {
    annotation = typeChecker.firstAnnotationOf(element.getter);
  }
  if (annotation != null) {
    return ConstantReader(annotation);
  }

  return null;
}
