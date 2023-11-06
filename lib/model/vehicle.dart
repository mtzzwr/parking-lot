import 'dart:convert';

class Vehicle {
  String? id;
  String? type;
  String? brand;
  String? model;
  String? plate;
  String? customerName;
  String? parkingSpot;
  String? entryTime;
  String? exitTime;

  Vehicle({
    this.id,
    this.type,
    this.brand,
    this.model,
    this.plate,
    this.customerName,
    this.parkingSpot,
    this.entryTime,
    this.exitTime,
  });

  @override
  bool operator ==(Object other) =>
      other is Vehicle &&
      other.brand == brand &&
      other.customerName == customerName &&
      other.exitTime == exitTime &&
      other.id == id &&
      other.model == model &&
      other.parkingSpot == parkingSpot &&
      other.plate == plate &&
      other.type == type &&
      other.entryTime == entryTime;

  factory Vehicle.fromJson(Map json) => Vehicle(
        id: json['id'],
        brand: json['brand'],
        customerName: json['customer_name'],
        model: json['model'],
        parkingSpot: json['parking_spot'],
        plate: json['plate'],
        type: json['type'],
        entryTime: json['entry_time'],
        exitTime: json['exit_time'],
      );

  static Map<String, dynamic> toJson(Vehicle vehicle) => {
        'id': vehicle.id,
        'type': vehicle.type,
        'brand': vehicle.brand,
        'model': vehicle.model,
        'plate': vehicle.plate,
        'customer_name': vehicle.customerName,
        'parking_spot': vehicle.parkingSpot,
        'entry_time': vehicle.entryTime,
        'exit_time': vehicle.exitTime,
      };

  static String encode(List<Vehicle> vehicles) => json.encode(
        vehicles
            .map<Map<String, dynamic>>((vehicle) => Vehicle.toJson(vehicle))
            .toList(),
      );

  static List<Vehicle> decode(String vehicles) =>
      (json.decode(vehicles) as List<dynamic>)
          .map<Vehicle>((item) => Vehicle.fromJson(item))
          .toList();
}
