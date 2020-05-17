import 'package:test/test.dart';
import 'package:to_string_helper_example_with_generator/example.dart';

void main() {
  group('toString() - minimal default configuration', () {
    test('Bike', () {
      expect(Bike().toString(), 'Bike{hasEngine=false, wheels=2}');
    });

    test('EBike', () {
      expect(EBike().toString(), 'EBike{hasEngine=true, color=null}');
    });

    test('FischerEBike', () {
      expect(FischerEBike().toString(), 'FischerEBike{color=red}');
    });
  });
}
