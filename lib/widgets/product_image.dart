import 'dart:io';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  ProductImage({Key? key, this.image}) : super(key: key);

  String? image;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          child: Container(
              width: double.infinity,
              height: 400,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  //borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 10,
                        offset: Offset(0, 5))
                  ]),
              child: _productImage(image)),
        ));
  }

  Widget _productImage(String? image) {
    if (image == null) {
      return const Image(
          image: AssetImage('assets/images/photo-camera.jpg'),
          fit: BoxFit.cover);
    }

    if (image.startsWith('http')) {
      return FadeInImage(
          placeholder: const AssetImage('assets/images/loading.gif'),
          image: NetworkImage(image),
          fit: BoxFit.fill);
    }

    return FadeInImage(
      placeholder: const AssetImage('assets/images/loading.gif'),
      image: FileImage(File(image)),
      fit: BoxFit.cover,
    );
  }
}
