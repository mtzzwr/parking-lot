import 'package:mobx/mobx.dart';
import 'package:parking_lot/model/vehicle.dart';
import 'package:uuid/uuid.dart';
part 'register_vehicle_store.g.dart';

class RegisterVehicleStore = _RegisterVehicleStoreBase
    with _$RegisterVehicleStore;

abstract class _RegisterVehicleStoreBase with Store {
  final uuid = const Uuid();

  @observable
  List parkingSpots = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];

  @observable
  List brands = [];

  @action
  void setBrands(List value) => brands = value;

  @observable
  String vehicleType = '';

  @action
  void setVehicleType(String value) => vehicleType = value;

  @observable
  String selectedBrand = '';

  @action
  void setSelectedBrand(String value) => selectedBrand = value;

  @observable
  String customerName = '';

  @action
  void setCustomerName(String value) => customerName = value;

  @observable
  String vehicleModel = '';

  @action
  void setVehicleModel(String value) => vehicleModel = value;

  @observable
  String parkingSpot = '';

  @action
  void setParkingSpot(String value) => parkingSpot = value;

  @observable
  String vehiclePlate = '';

  @action
  void setVehiclePlate(String value) => vehiclePlate = value;

  @observable
  Vehicle? vehicle;

  @action
  void setVehicle() {
    vehicle = Vehicle(
      id: uuid.v1(),
      type: vehicleType,
      brand: selectedBrand,
      model: vehicleModel,
      parkingSpot: parkingSpot,
      plate: vehiclePlate,
      customerName: customerName,
      entryTime: DateTime.now().toString(),
      exitTime: '',
    );
  }

  @computed
  bool get formDone =>
      selectedBrand.isNotEmpty &&
      vehicleModel.isNotEmpty &&
      vehiclePlate.isNotEmpty &&
      vehicleType.isNotEmpty &&
      parkingSpot.isNotEmpty;
}
