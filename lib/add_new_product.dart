import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resp_api/urls.dart';
import 'package:http/http.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  final TextEditingController productnamecontroller = TextEditingController();
  final TextEditingController productcodecontroller = TextEditingController();
  final TextEditingController qntontroller = TextEditingController();
  final TextEditingController unitpricecontroller = TextEditingController();
  final TextEditingController imagecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add new Product")),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter Your Value";
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                controller: productnamecontroller,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hint: Text("product name"),
                  label: Text("product name"),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter Your Value";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: productcodecontroller,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hint: Text("product code"),
                  label: Text("product code"),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter Your Value";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: qntontroller,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hint: Text("quantity"),
                  label: Text("quantity"),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter Your Value";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: unitpricecontroller,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hint: Text("Unit Price"),
                  label: Text("Unit Price"),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) {
                    return "Enter Your Value";
                  }
                  return null;
                },
                controller: imagecontroller,
                decoration: InputDecoration(
                  hint: Text("Image URL"),
                  label: Text("Image URL"),
                ),
              ),
              SizedBox(height: 20),
              FilledButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    _ontapAddNewProduct();
                  }
                },
                child: Text("Add new Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _ontapAddNewProduct() async {
    Uri url = Uri.parse(Urls.createproducturl);
    int total =
        int.parse(qntontroller.text) * int.parse(unitpricecontroller.text);
    Map<String, dynamic> responseBody = {
      "ProductName": productnamecontroller.text,
      "ProductCode": int.parse(productcodecontroller.text),
      "Img":
          "https://platform.theverge.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/25626805/DSC08374_alt_3.jpg?quality=90&strip=all&crop=0%2C0.02498750624688%2C100%2C99.950024987506&w=2400",
      "Qty": int.parse(qntontroller.text),
      "UnitPrice": int.parse(unitpricecontroller.text),
      "TotalPrice": total,
    };
    Response response = await post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(responseBody),
    );
    print(response.statusCode);
    print(response.body);
  }

  @override
  void dispose() {
    productcodecontroller.dispose();
    productnamecontroller.dispose();
    unitpricecontroller.dispose();
    qntontroller.dispose();
    imagecontroller.dispose();
    super.dispose();
  }
}
