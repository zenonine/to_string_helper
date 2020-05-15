import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:source_gen/source_gen.dart';
import 'package:to_string_helper/to_string_helper.dart';

class ToStringGenerator extends GeneratorForAnnotation<ToString> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError('@ToString() should only be annotated on class target', element: element);
    }
    final clazz = element as ClassElement;

    return _generateToStringMethod(clazz);
  }

  _generateToStringMethod(ClassElement clazz) {
    const objectName = 'o';
    var classname = clazz.name;
    final methodName = _getToStringMethodName(classname);

    // start method
    final sb = StringBuffer()..writeln('String $methodName($classname $objectName) {');

    // start return statement
    sb.writeln('return ToStringHelper($objectName)');

    // TODO: add fields

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
