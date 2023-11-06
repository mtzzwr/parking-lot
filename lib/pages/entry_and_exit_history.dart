import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_lot/controller/parking_lot_controller.dart';
import 'package:parking_lot/model/vehicle.dart';
import 'package:intl/intl.dart';
import 'package:parking_lot/pages/home_page.dart';

class EntryAndExitHistory extends StatefulWidget {
  const EntryAndExitHistory({super.key});

  @override
  State<EntryAndExitHistory> createState() => _EntryAndExitHistoryState();
}

class _EntryAndExitHistoryState extends State<EntryAndExitHistory> {
  final controller = ParkingLotController();

  List<Vehicle> vehicles = [];

  @override
  void initState() {
    super.initState();
    getVehicles();
  }

  void getVehicles() async {
    vehicles = await controller.getVehicles();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: AppBar(
        title: Text(
          'Histórico',
          style: GoogleFonts.raleway(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'Histórico de entradas e saídas',
                style: GoogleFonts.raleway(fontSize: 32),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: vehicles.map((e) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  margin: const EdgeInsets.all(12),
                  color: Colors.white,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            e.model!,
                            style: GoogleFonts.raleway(
                              fontSize: 28,
                            ),
                          ),
                          Text(
                            e.brand!,
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Placa: ${e.plate!}',
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Vaga: ${e.parkingSpot!}',
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Entrada: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(e.entryTime!))}',
                            style: GoogleFonts.raleway(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            e.exitTime!.isEmpty
                                ? ''
                                : 'Saída: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(e.exitTime!))}',
                            style: GoogleFonts.raleway(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
