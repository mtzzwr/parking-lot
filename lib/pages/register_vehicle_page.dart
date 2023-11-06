import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_lot/controller/parking_lot_controller.dart';
import 'package:parking_lot/pages/home_page.dart';
import 'package:parking_lot/stores/register_vehicle_store.dart';
import 'package:searchfield/searchfield.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterVehiclePage extends StatefulWidget {
  const RegisterVehiclePage({super.key});

  @override
  State<RegisterVehiclePage> createState() => _RegisterVehiclePageState();
}

class _RegisterVehiclePageState extends State<RegisterVehiclePage> {
  final store = RegisterVehicleStore();
  final controller = ParkingLotController();

  @override
  void initState() {
    super.initState();
    readJson();
  }

  void readJson() async {
    final response = await rootBundle.loadString('lib/data/car_brands.json');
    final data = await json.decode(response);
    store.setBrands(data);
  }

  void showRegisterVehicleConfirmation() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (_) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Veículo registrado com sucesso!',
                    style: GoogleFonts.raleway(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomePage(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Voltar',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          if (store.formDone) {
            store.setVehicle();
            bool registered = await controller.registerVehicle(store.vehicle!);
            if (registered) {
              showRegisterVehicleConfirmation();
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Vaga ocupada no momento'),
            ));
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Preencha as informações do veículo'),
          ));
          return;
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          color: Colors.black,
          child: Center(
            child: Text(
              'Registrar',
              style: GoogleFonts.raleway(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Registrar entrada',
          style: GoogleFonts.raleway(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const HomePage(),
              ),
              (Route<dynamic> route) => false,
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Entrada de veículo',
              style: GoogleFonts.raleway(fontSize: 44),
            ),
            Text(
              'Preencha os dados do veículo para registrar a entrada',
              style: GoogleFonts.raleway(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Selecione o tipo de veículo:',
              textAlign: TextAlign.start,
              style: GoogleFonts.raleway(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                vehicleTypeWidget('Carro', 'lib/assets/icons/car.png'),
                vehicleTypeWidget('Moto', 'lib/assets/icons/moto.png'),
                vehicleTypeWidget('Caminhão', 'lib/assets/icons/truck.png'),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Observer(
              builder: (_) => SearchField(
                searchInputDecoration: const InputDecoration(
                  labelText: 'Selecione a marca do veículo',
                  border: OutlineInputBorder(),
                ),
                onSuggestionTap: (SearchFieldListItem selectedItem) {
                  store.setSelectedBrand(selectedItem.searchKey);
                },
                suggestions: store.brands
                    .map(
                      (e) => SearchFieldListItem(
                        e['name'],
                        item: e,
                        child: Container(
                          height: 60,
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.network(e['logo']),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(e['name']),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextField(
                    onChanged: (value) {
                      store.setVehicleModel(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Modelo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(7),
                    ],
                    onChanged: (value) {
                      store.setVehiclePlate(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Placa',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    onChanged: (value) {
                      store.setCustomerName(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Nome do cliente (opcional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  flex: 1,
                  child: TextField(
                    onChanged: (value) {
                      store.setParkingSpot(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Vaga',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget vehicleTypeWidget(String type, String image) => GestureDetector(
        onTap: () => store.setVehicleType(type),
        child: Observer(builder: (_) {
          return Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: store.vehicleType == type ? Colors.white : Colors.black,
                width: 1,
              ),
              color: store.vehicleType == type ? Colors.black : Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  width: 38,
                  height: 38,
                  color:
                      store.vehicleType == type ? Colors.white : Colors.black,
                ),
                Text(
                  type,
                  style: GoogleFonts.raleway(
                    fontSize: 18,
                    color:
                        store.vehicleType == type ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
          );
        }),
      );
}
