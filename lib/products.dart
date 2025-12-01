// {
//             "_id": "692966e0a51bde4f61c13033",
//             "ProductName": " iphone16-pro",
//             "ProductCode": 1111111,
//             "Img": "https://platform.theverge.com/wp-content/uploads/sites/2/chorus/uploads/chorus_asset/file/25626805/DSC08374_alt_3.jpg?quality=90&strip=all&crop=0%2C0.02498750624688%2C100%2C99.950024987506&w=2400",
//             "Qty": 45,
//             "UnitPrice": 14,
//             "TotalPrice": 888
//         },

class ProductModel {
  late String product_name;
  late String id;
  late String img;
  late int quantity;
  late int unite_price;
  late int total;

  ProductModel.fromjson(Map<String, dynamic> p) {
    id = p['_id'];
    product_name = p['ProductName'];
    img = p['Img'];
    quantity = p['Qty'];
    unite_price = p['UnitPrice'];
    total = p['TotalPrice'];
  }
}
