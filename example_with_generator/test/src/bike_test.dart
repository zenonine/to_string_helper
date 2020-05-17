import 'package:test/test.dart';
import 'package:to_string_helper_example_with_generator/example.dart';

void main() {
  group('@ToString()', () {
    group('minimal default configuration', () {
      test('Bike', () {
        expect(Bike().toString(), 'Bike{wheels=2, hasEngine=false}');
      });

      test('EBike', () {
        expect(EBike().toString(), 'EBike{hasEngine=true, color=null}');
      });

      test('FischerEBike', () {
        expect(FischerEBike().toString(), 'FischerEBike{color=red}');
      });
    });

    group('@ToString(globalInclude)', () {
      test('TrekEBike', () {
        expect(TrekEBike().toString(),
            'TrekEBike{TrekEBike.name=Trek eBike, color=black}');
      });

      test('GiantEBike', () {
        expect(GiantEBike().toString(),
            'GiantEBike{GiantEBike._secondName=Giant eBike Next Generation}');
      });
    });

    group('@ToString(inclusion)', () {
      test('HerculesEBike', () {
        expect(HerculesEBike().toString(),
            'HerculesEBike{color=black, secondColor=null, hasEngine=true}');
      });

      test('Hercules2EBike', () {
        expect(Hercules2EBike().toString(),
            'Hercules2EBike{color=black, secondColor=null, hasEngine=true, wheels=2}');
      });

      test('Hercules3EBike', () {
        expect(Hercules3EBike().toString(),
            'Hercules3EBike{color=black, secondColor=null, wheels=2, hasEngine=true}');
      });
    });

    group('@ToString(nullString, separator, truncate, unnamedValue)', () {
      test('MoterraEBike', () {
        expect(MoterraEBike().toString(), 'MoterraEBike{bla\$NULL}');
      });
    });
  });

  group('@ToStringField()', () {
    group('@ToStringField(exclude)', () {
      test('HaibikeEBike', () {
        expect(HaibikeEBike().toString(),
            'HaibikeEBike{secondColor=null, _engine=Haibike, _gears=5}');
      });
    });

    group('@ToStringField(includeNullValue)', () {
      test('Haibike2EBike', () {
        expect(Haibike2EBike().toString(),
            'Haibike2EBike{color=black, _engine=Haibike2, _wheelSize=null}');
      });
    });

    group('@ToStringField(truncate)', () {
      test('Haibike3EBike', () {
        expect(
            Haibike3EBike().toString(),
            'Haibike3EBike{'
            'Haibike3EBike._secondName=Haibike3 e'
            ', color=black'
            ', secondColor=null'
            '}');
      });
    });

    group('@ToStringField(unnamedValue)', () {
      test('Haibike4EBike', () {
        expect(Haibike4EBike().toString(),
            'Haibike4EBike{black, secondColor=null}');
      });
    });
  });
}
