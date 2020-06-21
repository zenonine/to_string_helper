import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:to_string_helper/to_string_helper.dart';

import 'config_helper.dart';
import 'configs/config.dart';

class ToStringGenerator extends GeneratorForAnnotation<ToString> {
  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
          '@ToString() should only be annotated on target class',
          element: element);
    }
    final clazz = element as ClassElement;

    return _generateCode(clazz, getConfig(annotation, clazz));
  }

  String _generateCode(ClassElement clazz, Config config) {
    if (config.mixin) {
      return _generateToStringMethod(clazz, config) +
          '\n\n' +
          _generateToStringMixin(clazz.name);
    } else {
      return _generateToStringMethod(clazz, config);
    }
  }

  String _generateToStringMethod(ClassElement clazz, Config config) {
    const objectName = 'o';
    final classname = clazz.name;
    final methodName = _getToStringMethodName(classname);

    // start method
    final sb = StringBuffer()
      ..writeln('String $methodName($classname $objectName) {');

    // start return statement
    sb
      ..writeln('return ToStringHelper($objectName')
      ..writeln(defaultFormatConfig.nullString == config.format.nullString
          ? ''
          : ", nullString: '${config.format.nullString}'")
      ..writeln(defaultFormatConfig.separator == config.format.separator
          ? ''
          : ", separator: '${config.format.separator}'")
      ..writeln(defaultFormatConfig.truncate == config.format.truncate
          ? ''
          : ', truncate: ${config.format.truncate}')
      ..writeln(config.globalInclude.nullValue
          ? ''
          : ', includeNullValue: ${config.globalInclude.nullValue}')
      ..writeln(')');

    // Add fields
    for (final fieldConfig in config.fields) {
      final memberRef = fieldConfig.field.isStatic
          ? fieldConfig.id
          : '$objectName.${fieldConfig.id}';

      final unnamedValue =
          fieldConfig.format.unnamedValue ?? config.format.unnamedValue;

      sb
        ..writeln(unnamedValue ? '.addValue(' : ".add('${fieldConfig.id}', ")
        ..writeln('$memberRef')
        ..writeln(fieldConfig.format.truncate == null
            ? ''
            : ', truncate: ${fieldConfig.format.truncate}')
        ..writeln(
            fieldConfig.include.nullValue == config.globalInclude.nullValue
                ? ''
                : ', includeNullValue: ${fieldConfig.include.nullValue}')
        ..writeln(')');
    }

    // end return statement
    sb.writeln('.toString();');

    // close method
    sb.writeln('}');

    return sb.toString();
  }

  String _generateToStringMixin(String classname) {
    final mixinName = _getToStringMixinName(classname);
    final methodName = _getToStringMethodName(classname);

    final sb = StringBuffer();

    // start mixin
    sb.writeln('mixin $mixinName {');

    // mixin body
    sb
      ..writeln('@override')
      ..writeln('String toString() {')
      ..writeln('return $methodName(this as $classname);')
      ..writeln('}');

    // close mixin
    sb.writeln('}');

    return sb.toString();
  }

  String _getToStringMixinName(String classname) {
    return '_\$${classname}ToString';
  }

  String _getToStringMethodName(String classname) {
    return '_\$' +
        classname[0].toLowerCase() +
        classname.substring(1) +
        'ToString';
  }
}
