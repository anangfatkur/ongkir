// ignore_for_file: deprecated_member_use, camel_case_types, unused_element

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ongkirku/app/modules/home/city_model.dart';
import 'package:http/http.dart' as http;
import 'package:ongkirku/app/modules/home/controllers/home_controller.dart';

class buildKota extends GetView<HomeController> {
  const buildKota({
    required this.provinsiId,
    required this.tipe,
    Key? key,
  }) : super(key: key);

  final int provinsiId;
  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<City>(
        showClearButton: true,
        label: tipe == "asal"
            ? " Kota / Kabupaten Asal "
            : " Kota / Kabupaten Tujuan",
        onFind: (filter) async {
          Uri url = Uri.parse(
            "https://api.rajaongkir.com/starter/city?province=$provinsiId",
          );

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

            var listAllCity = data["rajaongkir"]["results"] as List<dynamic>;

            var models = City.fromJsonList(listAllCity);
            return models;
          } catch (err) {
            print(err);
            return List<City>.empty();
          }
        },
        onChanged: (kota) {
          if (kota != null) {
            if (tipe == "asal") {
              controller.kotaAsalId.value = int.parse(kota.cityId!);
            } else {
              controller.kotaTujuanId.value = int.parse(kota.cityId!);
            }
            // print(provinsi.province);
          } else {
            if (tipe == "asal") {
              print("Tidak Memilih Kota / Kabupaten Asal");
              controller.kotaAsalId.value = 0;
            } else {
              print("Tidak Memilih Kota / Kabupaten Tujuan");
              controller.kotaTujuanId.value = 0;
              // int.parse(provinsi.provinceId!);
            }
          }
            controller.showOngkir();
        },
        showSearchBox: true,
        dropdownSearchDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          hintText: "Cari Kota / Kabupaten...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "${item.type} ${item.cityName}",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          );
        },
        itemAsString: (item) => "${item!.type} ${item.cityName}",
      ),
    );
  }
}
