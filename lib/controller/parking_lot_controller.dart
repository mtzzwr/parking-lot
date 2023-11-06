import 'package:parking_lot/model/vehicle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParkingLotController {
  Future<bool> registerVehicle(Vehicle vehicle) async {
    final prefs = await SharedPreferences.getInstance();

    List<Vehicle> vehicles = await getVehicles();

    for (final v in vehicles) {
      if (v.parkingSpot == vehicle.parkingSpot) {
        return false;
      }
    }

    vehicles = vehicles..removeWhere((element) => element.id == vehicle.id);
    vehicles = vehicles..add(vehicle);

    final encodedData = Vehicle.encode(vehicles);
    prefs.remove('vehicles');
    bool registered = await prefs.setString('vehicles', encodedData);
    return registered;
  }

  Future<List<Vehicle>> getVehicles() async {
    final prefs = await SharedPreferences.getInstance();
    final existingVehicles = prefs.getString('vehicles') ?? '';

    if (existingVehicles.isEmpty) return [];
    final List<Vehicle> decodedVehicles = Vehicle.decode(existingVehicles);

    return decodedVehicles;
  }
}
