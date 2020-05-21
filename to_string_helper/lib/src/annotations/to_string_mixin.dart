import 'include.dart';
import 'to_string.dart';

class ToStringMixin extends ToString {
  const ToStringMixin({
    Include globalInclude,
    Map<Type, Include> inclusion,
    String nullString = 'null',
    String separator = ', ',
    int truncate = 0,
    bool unnamedValue = false,
  }) : super(
            globalInclude: globalInclude,
            inclusion: inclusion,
            nullString: nullString,
            separator: separator,
            truncate: truncate,
            unnamedValue: unnamedValue);
}
