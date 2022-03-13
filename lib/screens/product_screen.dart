import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/models/product_model.dart';
import 'package:login/providers/product_form_provider.dart';
import 'package:login/providers/product_provider.dart';
import 'package:login/widgets/product_image.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context);
    final ProductModel product = productProvider.productEdited;

    // TODO: implement build
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(product: product),
      child: _ProductScreenContent(productEdited: product));
  }
}


class _ProductScreenContent extends StatelessWidget {
  _ProductScreenContent({
    Key? key,
    required this.productEdited
  }) : super(key: key);

  late ProductModel productEdited;

  @override
  Widget build(BuildContext context) {

    final productFormProvider = Provider.of<ProductFormProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  ProductImage(image: productEdited.image),
                  Positioned(top: 40, left: 30, child: IconButton(onPressed: (){ Navigator.of(context).pop(); }, icon: productIcon(Icons.arrow_back_ios) )),
                  Positioned(top: 40, right: 30, child: IconButton(onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    final XFile? photo = await _picker.pickImage(source: ImageSource.camera, imageQuality: 100);

                    if(photo == null){
                      print('Imagen no cargada.');
                      return;
                    }
                    print(photo.path);
                    productProvider.updateProductImage(photo.path);

                  }, icon: productIcon(Icons.camera_alt))),
                ],
              ),
              ProductForm()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: productProvider.savingProduct ? const CircularProgressIndicator(color: Colors.white) : const Icon(Icons.save),
        onPressed: () async {
          if(productFormProvider.isValidForm()){

            FocusScope.of(context).unfocus();

            if(productProvider.newPictureFile != null) {
              final String? image = await productProvider.uploadProductImage();

              if (image != null) {
                productFormProvider.product!.image = image;
              }
            }

            await productProvider.saveProduct(productFormProvider.product!);
          }
        },
      ),
    );
  }

  Widget productIcon(IconData icon){

    return Container(
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black, blurRadius: 30)
            ]),
        child: Icon(icon, color: Colors.white)
    );
  }
}


class ProductForm extends StatefulWidget {
  ProductForm({Key? key}) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {

  bool available = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final productFormProvider = Provider.of<ProductFormProvider>(context);

    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
        child: Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(
                color: Colors.white
            ),
            child: Form(
              key: productFormProvider.formKey,
                child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text('Name'),
                      fillColor: Colors.deepPurple,
                      focusColor: Colors.deepPurple,
                      hoverColor: Colors.deepPurple
                  ),
                  initialValue: productFormProvider.product!.name,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'The name of product is required.';
                    }
                    return null;
                  },
                  onChanged: (value){
                    productFormProvider.product!.name = value;
                  },
                ),
                TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  decoration: const InputDecoration(
                      label: Text('Price'),
                      fillColor: Colors.deepPurple,
                      focusColor: Colors.deepPurple,
                      hoverColor: Colors.deepPurple
                  ),
                  initialValue: productFormProvider.product!.price.toString(),
                  onChanged: (value){
                    if(double.tryParse(value) == null){
                      productFormProvider.product!.price = 0;
                    }else{
                      productFormProvider.product!.price = double.parse(value);
                    }
                  },
                ),
                SwitchListTile.adaptive(title: const Text('Available'), subtitle: const Text('Are there product in stock?'), activeColor: Colors.deepPurple, value: productFormProvider.product!.avaliable, onChanged: (value){
                  setState(() {
                    productFormProvider.product!.avaliable = value;
                  });
                }),
              ],
            ))
        ),
      ),
    );
  }
}
