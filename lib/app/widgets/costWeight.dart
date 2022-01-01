// ignore_for_file: deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './../modules/home/controllers/home_controller.dart';

class Weight extends GetView<HomeController> {
  const Weight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: false,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: controller.weightController,
              decoration: InputDecoration(
                labelText: "Berat Barang",
                hintText: "Masukan Berat Barang",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.ubahBerat(value),
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 150,
            // color: Colors.blue,
            child: DropdownSearch<String>(
                mode: Mode.BOTTOM_SHEET,
                showSelectedItems: true,
                showSearchBox: true,
                // dropdownSearchDecoration: InputDecoration(
                //   hintText: "Cari Satuan",
                //   border: OutlineInputBorder(),
                // ),
                items: [
                  "ton",
                  "kwintal",
                  "kg",
                  "gram",
                  "ons",
                ],
                label: "Satuan Berat",
                onChanged: (value) => controller.ubahSatuan(value!),
                selectedItem: "gram"),
          )
        ],
      ),
    );
  }
}
