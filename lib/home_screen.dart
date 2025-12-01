import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resp_api/add_new_product.dart';
import 'package:resp_api/products.dart';
import 'package:resp_api/urls.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ProductModel> _listOfproducts = [];
  bool isloading = false;
  Future<void> get_response() async {
    _listOfproducts.clear();
    isloading = true;
    setState(() {});
    Uri url = Uri.parse(Urls.getproducturl);
    Response response = await get(url);
    debugPrint(response.body);
    if (response.statusCode == 200) {
      final decodedjson = jsonDecode(response.body);
      for (Map<String, dynamic> p in decodedjson['data']) {
        ProductModel product = ProductModel.fromjson(p);

        _listOfproducts.add(product);
        isloading = false;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    get_response();
    print(_listOfproducts);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (ctx) => AddNewProduct()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("list of products"),
        actions: [
          IconButton(
            onPressed: () {
              get_response();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Visibility(
        visible: isloading == false,
        replacement: Center(child: CircularProgressIndicator()),
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: _listOfproducts.length,
          itemBuilder: (BuildContext, index) {
            return ListTile(
              trailing: PopupMenuButton<productOptions>(
                onSelected: (productOptions option) {
                  if (option == productOptions.delete) {
                    _deleteproduct(_listOfproducts[index].id);
                  }
                },
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: productOptions.delete,
                      child: Text("DELETE"),
                    ),
                    PopupMenuItem(
                      value: productOptions.update,
                      child: Text("Update"),
                    ),
                  ];
                },
              ),
              leading: CircleAvatar(
                child: Image.network(
                  _listOfproducts[index].img,
                  errorBuilder: (_, __, ___) {
                    return Icon(Icons.error);
                  },
                ),
              ),
              title: Text(_listOfproducts[index].product_name),
              subtitle: Text(_listOfproducts[index].total.toString()),
            );
          },
        ),
      ),
    );
  }

  Future<void> _deleteproduct(String id) async {
    Uri url = Uri.parse(Urls.deleteurl(id));
    Response response = await get(url);
    debugPrint(response.body);
    if (response.statusCode == 200) {}
    setState(() {});
    get_response();
  }
}

enum productOptions { delete, update }
