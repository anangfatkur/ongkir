// ignore_for_file: deprecated_member_use, unrelated_type_equality_checks

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '/app/widgets/city.dart';
import '/app/widgets/province.dart';
import '/app/widgets/costWeight.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ongkir Ku'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          buildProvinsi(
            tipe: "asal",
          ),
          Obx(
            () => controller.hidKotaAsal.isTrue
                ? SizedBox()
                : buildKota(
                    provinsiId: controller.provinsiAsalId.value,
                    tipe: "asal",
                  ),
          ),
          buildProvinsi(
            tipe: "tujuan",
          ),
          Obx(
            () => controller.hidKotaTujuan.isTrue
                ? SizedBox()
                : buildKota(
                    provinsiId: controller.provinsiTujuanId.value,
                    tipe: "tujuan",
                  ),
          ),
          Weight(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: DropdownSearch<Map<String, dynamic>>(
              mode: Mode.MENU,
              showClearButton: true,
              // showSelectedItems: true,
              items: [
                {
                  "code": "jne",
                  "name": "Jalur Nugraha Ekakurir(JNE)",
                },
                {
                  "code": "tiki",
                  "name": "Titipan Kilat(TIKI)",
                },
                {
                  "code": "pos",
                  "name": "Perusahaan Operasional Surat(POS)",
                }
              ],
              label: "Kirim Lewat",
              hint: "Pilih kirim",

              onChanged: (value) {
                if (value != null) {
                  controller.kirimLewat.value = value["code"];
                  controller.showOngkir();
                } else {
                  controller.hidOngkir.value = true;
                  controller.kirimLewat.value = "";
                }
              },
              itemAsString: (item) => "${item!['name']}",

              popupItemBuilder: (context, item, isSelected) => Container(
                padding: EdgeInsets.all(20),
                child: Text(
                  "${item['name']}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => controller.hidOngkir.isTrue
                ? SizedBox()
                : ElevatedButton(
                    onPressed: () => controller.totalOngkir(),
                    child: Text("Cek Ongkos Kirim"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                      ),
                      primary: Colors.blueGrey,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
