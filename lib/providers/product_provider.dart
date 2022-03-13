
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:login/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {

  //NOTA: A la URL base no se le pone http cuando se utiliza la lib http
  final String _baseURL = 'flutter-projects-83160-default-rtdb.firebaseio.com';
  final List<ProductModel> products = [];
  late ProductModel productEdited;
  File? newPictureFile;
  bool savingProduct = false;

  ProductProvider(){
    getProducts();
  }


  getProducts() async {
    final url = Uri.https(_baseURL, '/products.json');
    final response = await http.get(url);

    Map<String, dynamic> res =  json.decode(response.body);

    res.forEach((key, value) {
      final product = ProductModel.fromMap(value);
      product.id = key;
      products.add(product);
    });
    notifyListeners();
  }

  saveProduct(ProductModel product) async {

    savingProduct = true;
    notifyListeners();

    if (product.id == null) {
     await insertProduct(product);
    }
    else{
     await updateProduct(product);
    }

    savingProduct = false;
    notifyListeners();
  }

  insertProduct(ProductModel product) async {

    final url = Uri.https(_baseURL, '/products.json');
    final response = await http.post(url, body: product.toJson());

    if(response.statusCode == 200){
      final body = json.decode(response.body);
      product.id = body['name'];
      products.add(product);
      notifyListeners();
    }
  }

  updateProduct(ProductModel product) async {

    final url = Uri.https(_baseURL, '/products/${product.id}.json');
    final response = await http.put(url, body: product.toJson());

    if(response.statusCode == 200){
      final index = products.indexWhere((element) => element.id == product.id);
      products[index] = product;
      notifyListeners();
    }
  }

  updateProductImage(String? image){

    productEdited.image = image;
    newPictureFile = File.fromUri(Uri(path: image));
    notifyListeners();
  }

  Future<String?> uploadProductImage() async {

    if(productEdited.image == null) return null;

    savingProduct = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/duanlykbq/image/upload?upload_preset=ml_default');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    // if you need more parameters to parse, add those like this. i added "user_id". here this "user_id" is a key of the API request
    //request.fields["user_id"] = "text";

    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    //Informacion que se espera de la peticion.
    final streamResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamResponse);

    final body = json.decode(response.body);

    newPictureFile = null;
    notifyListeners();
    return body['url'];
  }

}