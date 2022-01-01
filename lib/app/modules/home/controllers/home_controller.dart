// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // //TODO: Implement HomeController

  // final count = 0.obs;
  // @override
  void onInit() {
    weightController = TextEditingController(text: "$berat");
    // super.onInit();
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  void onClose() {
    weightController.dispose();
    super.onClose();
  }
  // void increment() => count.value++;

  var hidKotaAsal = true.obs;
  var provinsiAsalId = 0.obs;
  var kotaAsalId = 0.obs;
  var hidKotaTujuan = true.obs;
  var provinsiTujuanId = 0.obs;
  var kotaTujuanId = 0.obs;
  var hidOngkir = true.obs;
  var kirimLewat = "".obs;

  late TextEditingController weightController;

  void showOngkir() {
    if (kotaAsalId != 0 && kotaTujuanId != 0 && berat > 0 && kirimLewat != "") {
      hidOngkir.value = false;
    } else {
      hidOngkir.value = true;
    }
  }

  void ubahBerat(String value) {
    berat = double.tryParse(value) ?? 0.0;
    String cekSatuan = satuan;
    switch (cekSatuan) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "gram":
        berat = berat;
        break;
      case "ons":
        berat = berat * 100;
        break;
      default:
        berat = berat;
    }
    print("$berat gram");
    showOngkir();

  }

  void ubahSatuan(String value) {
    berat = double.tryParse(weightController.text) ?? 0.0;
    switch (value) {
      case "ton":
        berat = berat * 1000000;
        break;
      case "kwintal":
        berat = berat * 100000;
        break;
      case "kg":
        berat = berat * 1000;
        break;
      case "gram":
        berat = berat;
        break;
      case "ons":
        berat = berat * 100;
        break;
      default:
        berat = berat;
    }
    satuan = value;
    print("$berat gram");
    showOngkir();
  }

  double berat = 0.0;
  String satuan = "gram";
}
