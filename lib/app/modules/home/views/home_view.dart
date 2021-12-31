// ignore_for_file: deprecated_member_use, camel_case_types

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../city_model.dart';
import '../province_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongkir Ku'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          _buildProvinsi(),
          Obx(
            () => controller.hidKota.isTrue
                ? SizedBox()
                : _buildKota(
                    provinsiId: controller.provinsiId.value,
                  ),
          ),
        ],
      ),
    );
  }
}

class _buildProvinsi extends GetView<HomeController> {
  const _buildProvinsi({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<Province>(
        showClearButton: true,
        label: "Provinsi",
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
            controller.hidKota.value = false;
            controller.provinsiId.value = int.parse(provinsi.provinceId!);
            // print(provinsi.province);
          } else {
            controller.hidKota.value = true;
            controller.provinsiId.value = 0;
            // print("Tidak Memilih Provinsi");
          }
        },
        showSearchBox: true,
        dropdownSearchDecoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 25,
          ),
          hintText: "Cari Provinsi...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
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

class _buildKota extends StatelessWidget {
  const _buildKota({
    required this.provinsiId,
    Key? key,
  }) : super(key: key);

  final int provinsiId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownSearch<City>(
        showClearButton: true,
        label: "Kota / Kabupaten",
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
            print(kota.cityName);
          } else {
            print("Tidak Memilih Kota / Kabupaten");
          }
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
