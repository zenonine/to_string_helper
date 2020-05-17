import 'package:test/test.dart';
import 'package:to_string_helper_example_with_generator/example.dart';

void main() {
  group('toString()', () {
    group('minimal default configuration', () {
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

    group('customize globalInclude', () {
      test('TrekEBike', () {
        expect(TrekEBike().toString(),
            'TrekEBike{TrekEBike.name=Trek eBike, color=black}');
      });

      test('GiantEBike', () {
        expect(GiantEBike().toString(),
            'GiantEBike{GiantEBike._secondName=Giant eBike Next Generation}');
      });
    });
  });
}
