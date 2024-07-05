import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class api extends StatefulWidget {
  const api({super.key});

  @override
  State<api> createState() => _apiState();
}

class _apiState extends State<api> {
  List<Product> _product = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  Future<void> fetchdata() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      final productJson = json.decode(response.body);
      setState(() {
        _product = List<Product>.from(
            productJson.map((productJson) => Product.fromJson(productJson)));
      });
    } else {
      throw Exception('failed to load ');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _product.length,
          itemBuilder: (context, index) {
            final photo = _product[index];
            return Column(
              children: [
                Card(
                  child: ListTile(
                    leading: Image.network(
                      photo.image,
                      fit: BoxFit.fill,
                    ),
                    title: Text(photo.title),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            );
          }),
    );
  }
}
