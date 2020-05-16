import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:to_string_helper/to_string_helper.dart';

import 'config_helper.dart';
import 'configs/config.dart';

class ToStringGenerator extends GeneratorForAnnotation<ToString> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError('@ToString() should only be annotated on class target', element: element);
    }
    final clazz = element as ClassElement;

    return _generateToStringMethod(clazz, getConfig(annotation, clazz));
  }

  _generateToStringMethod(ClassElement clazz, Config config) {
    const objectName = 'o';
    var classname = clazz.name;
    final methodName = _getToStringMethodName(classname);

    // start method
    final sb = StringBuffer()..writeln('String $methodName($classname $objectName) {');

    // start return statement
    sb
      ..writeln('return ToStringHelper($objectName')
      ..writeln(defaultFormatConfig.nullString == config.format.nullString
          ? ''
          : ", nullString: '${config.format.nullString}'")
      ..writeln(
          defaultFormatConfig.separator == config.format.separator ? '' : ", separator: '${config.format.separator}'")
      ..writeln(defaultFormatConfig.truncate == config.format.truncate ? '' : ', truncate: ${config.format.truncate}')
      ..writeln(')');

    // Add fields
    config.fields.forEach((fieldConfig) {
      final memberRef = fieldConfig.field.isStatic ? fieldConfig.id : '$objectName.${fieldConfig.id}';

      final unnamedValue = fieldConfig.format.unnamedValue ?? config.format.unnamedValue;

      sb
        ..writeln(unnamedValue ? '.addValue(' : ".add('${fieldConfig.id}', ")
        ..writeln('$memberRef')
        ..writeln(fieldConfig.format.truncate == null ? '' : ', truncate: ${fieldConfig.format.truncate}')
        ..writeln(')');
    });

    // end return statement
    sb.writeln('.toString();');

    // close method
    sb.writeln('}');

    return sb.toString();
  }

  String _getToStringMethodName(String classname) {
    return '_\$' + classname[0].toLowerCase() + classname.substring(1) + 'ToString';
  }
}
