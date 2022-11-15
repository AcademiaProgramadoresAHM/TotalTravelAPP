import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/Packages.dart';

class SearchPackageDelegate extends SearchDelegate {
  // final List<Country> countries;

  // List<Country> _filter = [];

  // SearchCountryDelegate(this.countries);

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
    return Center();
    // _filter = countries.where((country) {
    //   return country.name.toLowerCase().contains(query.trim().toLowerCase());
    // }).toList();
    // return ListView.builder(
    //   itemCount: _filter.length,
    //   itemBuilder: (_, index) {
    //     return ListTile(
    //       title: Text(_filter[index].name),
    //     );
    //   },
    // );
  }
}

class Listpackage {
  String nombre;

  Listpackage(this.nombre);
}
