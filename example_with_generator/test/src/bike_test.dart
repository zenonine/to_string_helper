import 'package:test/test.dart';
import 'package:to_string_helper_example_with_generator/example.dart';

void main() {
  group('toString() - default minimal configuration', () {
    test('Bike', () {
      expect(Bike().toString(), 'Bike{hasEngine=false, wheels=2}');
    });
    test('EBike - inherited fields should not be printed', () {
      expect(EBike().toString(), 'EBike{hasEngine=true}');
    });
  });
}
