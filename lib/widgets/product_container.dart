import 'package:flutter/material.dart';
import 'package:login/models/product_model.dart';

class ProductContainer extends StatelessWidget {

  ProductContainer({
    Key? key,
    required this.product,
  }) : super(key: key);

  late ProductModel product;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      height: 400,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: _buildBoxDecoration(),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          product.image == null ? _ImageContainer() : _ImageContainer(image: product.image),
          _ProductDetails(id: product.id!, name: product.name),
          Positioned( top: 0, child: _PriceContainer(price: product.price)),
          product.avaliable ? Container() : Positioned( top: 0, child: _AvalibleContainer()),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(color: Colors.black, offset: Offset(0, 0.5), blurRadius: 10)
        ],
      );
}

class _ImageContainer extends StatelessWidget {

  _ImageContainer({
    Key? key,
    this.image
  }) : super(key: key);

  String? image;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15)),
            child: FadeInImage(
            placeholder: const AssetImage('assets/images/loading.gif'),
            image: image == null ? const AssetImage('assets/images/photo-camera.jpg') : NetworkImage(image!) as ImageProvider,
            fit: BoxFit.fill
            ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {

  _ProductDetails({
    Key? key,
    required this.id,
    required this.name,
  }) : super(key: key);

  late String id;
  late String name;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
          width: double.infinity,
          height: 70,
          margin: const EdgeInsets.only(right: 80),
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), topRight: Radius.circular(15)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name, maxLines: 1, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                Text(id, maxLines: 1, style: const TextStyle(fontSize: 12, color: Colors.white))
              ],
            ),
          ),
    );
  }
}

class _PriceContainer extends StatelessWidget {
  _PriceContainer({
    Key? key,
    required this.price
  }) : super(key: key);

  late double price;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 100,
      height: 50,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 242.8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
        color: Colors.deepPurple
      ),
      child: FittedBox( fit: BoxFit.contain, child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("\$ $price USD", style: const TextStyle(color: Colors.white, fontSize: 16), maxLines: 1),
      )),
    );
  }
}

class _AvalibleContainer extends StatelessWidget {
  _AvalibleContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 100,
      height: 50,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(right: 242.8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
          color: Colors.orange
      ),
      child: const FittedBox( fit: BoxFit.contain, child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text("not available", style: TextStyle(color: Colors.white, fontSize: 16), maxLines: 1),
      )),
    );
  }
}
