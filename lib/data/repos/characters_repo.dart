

import '../models/char-quotes.dart';
import '../models/products.dart';
import '../web_services/characters_web_services.dart';

class ProductRepo {
  final ProductsWebServices productsWebServices;

  ProductRepo(this.productsWebServices);

  Future<List<Product>> getAllCharacters() async {
    List<Product> products = await productsWebServices.getAllProducts();
    return products;
  }

  // Future<List<Quote>> getAllCharQuotes(String charName) async {
  //   final qoutes = await productsWebServices.getAllQuotes(charName);
  //   return qoutes.map((e) => Quote.fromJson(e)).toList();
  // }


}
