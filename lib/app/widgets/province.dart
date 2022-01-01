// ignore_for_file: deprecated_member_use, unused_element, camel_case_types

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/home/controllers/home_controller.dart';
import '../modules/home/province_model.dart';

import 'package:http/http.dart' as http;

class buildProvinsi extends GetView<HomeController> {
  const buildProvinsi({
    Key? key,
    required this.tipe,
  }) : super(key: key);

  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Province>(
        showClearButton: true,
        label: tipe == "asal" ? "Provinsi Asal " : "Provinsi Tujuan",
        onFind: (filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

          try {
            final response = await http.get(
              url,
              headers: {
                "key": "a76d61456e6590daf8173208032be001",
              },
            );

            var data = json.decode(response.body) as Map<String, dynamic>;

            var statusCode = data["rajaongkir"]["status"]["code"];

            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var listAllProvince =
                data["rajaongkir"]["results"] as List<dynamic>;

            var models = Province.fromJsonList(listAllProvince);
            return models;
          } catch (err) {
            print(err);
            return List<Province>.empty();
          }
        },
        onChanged: (provinsi) {
          if (provinsi != null) {
            if (tipe == "asal") {
              controller.hidKotaAsal.value = false;
              controller.provinsiAsalId.value = int.parse(provinsi.provinceId!);
            } else {
              controller.hidKotaTujuan.value = false;
              controller.provinsiTujuanId.value =
                  int.parse(provinsi.provinceId!);
            }

            // print(provinsi.province);

          } else {
            if (tipe == "asal") {
              controller.hidKotaAsal.value = true;
              controller.provinsiTujuanId.value = 0;
            } else {
              controller.hidKotaTujuan.value = false;
              controller.provinsiTujuanId.value = 0;
              // int.parse(provinsi.provinceId!);
            }
            // print("Tidak Memilih Provinsi");
          }
            controller.showOngkir();
        },
        showSearchBox: true,
        dropdownSearchDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          hintText: "Cari Provinsi...",
          border: OutlineInputBorder(
              // borderRadius: BorderRadius.circular(50),
              ),
        ),
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "${item.province}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          );
        },
        itemAsString: (item) => item!.province!,
      ),
    );
  }
}
