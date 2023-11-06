import 'package:flutter_test/flutter_test.dart';
import 'package:parking_lot/controller/parking_lot_controller.dart';
import 'package:parking_lot/model/vehicle.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Must insert a new vehicle into the storage', () async {
    final controller = ParkingLotController();

    Vehicle vehicle = Vehicle(
      id: '1',
      brand: 'Chevrolet',
      model: 'Onix',
      customerName: 'Caio',
      entryTime: DateTime.now().toString(),
      exitTime: '',
      parkingSpot: '8',
      plate: 'BRA2E19',
      type: 'carro',
    );

    SharedPreferences.setMockInitialValues({});

    expect(await controller.registerVehicle(vehicle), true);
  });
}
