import 'package:flutter/material.dart';
import 'package:login/Widgets/product_container.dart';
import 'package:login/models/product_model.dart';
import 'package:login/providers/product_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),

      body: products.length == 0 ? Container(alignment: Alignment.center, child: const CircularProgressIndicator(color: Colors.deepPurple,)) : ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index){
            return GestureDetector(
                onTap: (){
                  productProvider.productEdited = products[index].copy();
                  print(productProvider.productEdited.image);
                  Navigator.of(context).pushNamed('/product');
                },
                child: ProductContainer(product: products[index])
            );
          }
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productProvider.productEdited = ProductModel(avaliable: false, name: '', price: 0);
          Navigator.of(context).pushNamed('/product');
        },
      ),
    );
  }
}
