class Urls {
  static const String _baseurl = "http://35.73.30.144:2008/api/v1";
  static const String getproducturl = "$_baseurl/ReadProduct";
  static const String createproducturl = "$_baseurl/CreateProduct";
  static String deleteurl(String ID) => "$_baseurl/DeleteProduct/$ID";
}
