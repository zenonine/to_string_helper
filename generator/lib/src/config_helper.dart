import 'dart:collection';

import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:to_string_helper/to_string_helper.dart';

import 'configs/config.dart';
import 'configs/field_config.dart';
import 'configs/field_format_config.dart';
import 'configs/format_config.dart';

const defaultFormatConfig = FormatConfig();
const defaultInclude = Include(
  nullValue: true,
  nonStatic: true,
  static: false,
  public: true,
  private: false,
);

Config getConfig(ConstantReader annotation, ClassElement classElement) {
  return Config(
    format: FormatConfig(
      nullString: _peek(annotation, 'nullString')?.stringValue ??
          defaultFormatConfig.nullString,
      separator: _peek(annotation, 'separator')?.stringValue ??
          defaultFormatConfig.separator,
      truncate: _peek(annotation, 'truncate')?.intValue ??
          defaultFormatConfig.truncate,
      unnamedValue: _peek(annotation, 'unnamedValue')?.boolValue ??
          defaultFormatConfig.unnamedValue,
    ),
    globalInclude: _getInclude(_peek(annotation, 'globalInclude')),
    fields: _getFieldConfigs(annotation, classElement),
  );
}

Set<FieldConfig> _getFieldConfigs(
    ConstantReader annotation, ClassElement classElement) {
  final LinkedHashSet<FieldConfig> fieldConfigs = LinkedHashSet();

  _getIncludes(annotation, classElement).forEach((e, include) {
    for (final fieldElement in e.fields) {
      final prefix = fieldElement.isStatic ? '${e.name}.' : '';

      final fieldAnnotation = _getFieldAnnotation(fieldElement, ToStringField);

      fieldConfigs.add(FieldConfig(
        '$prefix${fieldElement.name}',
        field: fieldElement,
        include: Include(
          nullValue: _peek(fieldAnnotation, 'includeNullValue')?.boolValue ??
              include.nullValue,
          nonStatic: include.nonStatic,
          static: include.static,
          public: include.public,
          private: include.private,
        ),
        exclude: _peek(fieldAnnotation, 'exclude')?.boolValue ?? false,
        format: FieldFormatConfig(
          truncate: _peek(fieldAnnotation, 'truncate')?.intValue,
          unnamedValue: _peek(fieldAnnotation, 'unnamedValue')?.boolValue,
        ),
      ));
    }
  });

  return LinkedHashSet.of(fieldConfigs.where((fc) => _isIncludedField(fc)));
}

Map<ClassElement, Include> _getIncludes(
    ConstantReader annotation, ClassElement classElement) {
  final globalInclude = _getInclude(_peek(annotation, 'globalInclude'));
  final inclusionReaders = _peek(annotation, 'inclusion')?.mapValue?.map(
      (type, include) =>
          MapEntry(ConstantReader(type), ConstantReader(include)));

  inclusionReaders?.removeWhere((typeReader, includeReader) {
    // only retrieve configuration for type ClassElement
    if (typeReader.typeValue?.element is! ClassElement) {
      return true;
    }

    // retrieve configuration for current class
    if (typeReader.typeValue == classElement.thisType) {
      return false;
    }

    // retrieve configuration for super classes
    return !classElement.allSupertypes.contains(typeReader.typeValue);
  });

  final Map<ClassElement, Include> includes = inclusionReaders == null
      ? {}
      : inclusionReaders?.map((typeReader, includeReader) {
          return MapEntry(typeReader.typeValue.element as ClassElement,
              _getInclude(includeReader, globalInclude));
        });

  // make sure the current class is included and at the first position
  final result = LinkedHashMap.of({classElement: globalInclude});
  result.addAll(includes);
  return result;
}

Include _getInclude(ConstantReader cr, [Include overwriteDefaultInclude]) {
  return Include(
    nullValue: _peek(cr, 'nullValue')?.boolValue ??
        overwriteDefaultInclude?.nullValue ??
        defaultInclude.nullValue,
    nonStatic: _peek(cr, 'nonStatic')?.boolValue ??
        overwriteDefaultInclude?.nonStatic ??
        defaultInclude.nonStatic,
    static: _peek(cr, 'static')?.boolValue ??
        overwriteDefaultInclude?.static ??
        defaultInclude.static,
    public: _peek(cr, 'public')?.boolValue ??
        overwriteDefaultInclude?.public ??
        defaultInclude.public,
    private: _peek(cr, 'private')?.boolValue ??
        overwriteDefaultInclude?.private ??
        defaultInclude.private,
  );
}

bool _isIncludedField(FieldConfig fc) {
  if (fc.exclude) {
    return false;
  }

  if (!fc.include.nonStatic && !fc.field.isStatic) {
    return false;
  }
  if (!fc.include.static && fc.field.isStatic) {
    return false;
  }

  if (!fc.include.public && fc.field.isPublic) {
    return false;
  }

  if (!fc.include.private && fc.field.isPrivate) {
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
