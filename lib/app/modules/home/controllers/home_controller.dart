// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ongkirku/app/modules/home/courier_model.dart';

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
    // ignore: unrelated_type_equality_checks
    if (kotaAsalId != 0 && kotaTujuanId != 0 && berat > 0 && kirimLewat != "") {
      hidOngkir.value = false;
    } else {
      hidOngkir.value = true;
    }
  }

  void totalOngkir() async {
    Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
    try {
      final response = await http.post(
        url,
        body: {
          "origin": "$kotaAsalId",
          "destination": "$kotaTujuanId",
          "weight": "$berat",
          "courier": "$kirimLewat",
        },
        headers: {
          "key": "a76d61456e6590daf8173208032be001",
          "content-type": "application/x-www-form-urlencoded",
        },
      );
      var data = json.decode(response.body) as Map<String, dynamic>;
      var results = data["rajaongkir"]["results"] as List<dynamic>;

      var listAllCourier = Courier.fromJsonList(results);
      var courier = listAllCourier[0];
      // print();

      Get.defaultDialog(
        title: courier.name!,
        content: Column(
          children: courier.costs!
              .map(
                (e) => ListTile(
                  title: Text("${e.service}"),
                  subtitle: Text("Rp ${e.cost![0].value}"),
                  trailing: Text(
                    courier.code == "pos"
                        ? "${e.cost![0].etd}"
                        : "${e.cost![0].etd} HARI",
                  ),
                ),
              )
              .toList(),
        ),
      );
    } catch (e) {
      print(e);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: e.toString(),
      );
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
