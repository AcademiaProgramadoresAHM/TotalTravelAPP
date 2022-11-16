import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Packages.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../Models/DefaultPackageViewModel.dart';

class SearchPackageDelegate extends SearchDelegate {
  // final Future<List<Listpackage>>? listado;
  // final List<Country> countries;
  // final List<Listpackage> listtt;
  final List<DefaultPackageModelList> klkmmhv;

  SearchPackageDelegate(this.klkmmhv);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
    // return ListView.builder(
    //   itemCount: _filter.length,
    //   itemBuilder: (_, index) {
    //     return ListTile(
    //       title: Text(_filter[index].name),
    //     );
    //   },
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: klkmmhv.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(4),
          child: Text(klkmmhv[index].nombre.toString()),
        );
      },
    );
  }
}

class DefaultPackageModelList {
  int? id;
  String? nombre;
  String? descripcionPaquete;
  String? duracionPaquete;
  double? precio;
  DefaultPackageModelList(this.id, this.nombre, this.descripcionPaquete,
      this.duracionPaquete, this.precio);

  DefaultPackageModelList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nombre = json['nombre'];
    descripcionPaquete = json['descripcionPaquete'];
    duracionPaquete = json['duracionPaquete'];
    precio = json['precio'];
  }
}

List<Padding> ListBuscador(List<dynamic> data, context) {
  List<Padding> list = [];
  data.forEach((element) {
    list.add(Padding(
        padding: EdgeInsets.all(4),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              child: Row(
                children: [
                  Flexible(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                        child: Text(
                          element['nombre'],
                          style: TextStyle(fontSize: 20),
                        ),
                      ))
                ],
              ),
              decoration: BoxDecoration(color: white, boxShadow: [
                BoxShadow(
                    color: grey,
                    blurRadius: 2,
                    spreadRadius: 2,
                    offset: Offset(1.0, 1.0))
              ]),
            ),
          ],
        )));
  });
  return list;
}
