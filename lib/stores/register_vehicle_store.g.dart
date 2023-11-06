// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_vehicle_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterVehicleStore on _RegisterVehicleStoreBase, Store {
  late final _$brandsAtom =
      Atom(name: '_RegisterVehicleStoreBase.brands', context: context);

  @override
  List<dynamic> get brands {
    _$brandsAtom.reportRead();
    return super.brands;
  }

  @override
  set brands(List<dynamic> value) {
    _$brandsAtom.reportWrite(value, super.brands, () {
      super.brands = value;
    });
  }

  late final _$vehicleTypeAtom =
      Atom(name: '_RegisterVehicleStoreBase.vehicleType', context: context);

  @override
  String get vehicleType {
    _$vehicleTypeAtom.reportRead();
    return super.vehicleType;
  }

  @override
  set vehicleType(String value) {
    _$vehicleTypeAtom.reportWrite(value, super.vehicleType, () {
      super.vehicleType = value;
    });
  }

  late final _$_RegisterVehicleStoreBaseActionController =
      ActionController(name: '_RegisterVehicleStoreBase', context: context);

  @override
  void setBrands(List<dynamic> value) {
    final _$actionInfo = _$_RegisterVehicleStoreBaseActionController
        .startAction(name: '_RegisterVehicleStoreBase.setBrands');
    try {
      return super.setBrands(value);
    } finally {
      _$_RegisterVehicleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVehicleType(String value) {
    final _$actionInfo = _$_RegisterVehicleStoreBaseActionController
        .startAction(name: '_RegisterVehicleStoreBase.setVehicleType');
    try {
      return super.setVehicleType(value);
    } finally {
      _$_RegisterVehicleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
brands: ${brands},
vehicleType: ${vehicleType}
    ''';
  }
}
