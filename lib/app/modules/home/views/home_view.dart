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
          Weight()
        ],
      ),
    );
  }
}
