
import 'package:flutter/cupertino.dart';
import 'package:login/models/product_model.dart';

class ProductFormProvider extends ChangeNotifier {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ProductModel? product;

  ProductFormProvider({this.product});

  bool isValidForm(){

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      return true;
    }
    return false;
  }
}