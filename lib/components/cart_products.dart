import 'package:flutter/material.dart';
import 'package:fashionapp/modules/single_cart_product.dart';
class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var products_on_the_cart =[
    {
      "name":"Blazer",
      "bicture":"assets/images/products/blazer1.jpeg",
      "old_price":120,
      "price":85,
      "size":"M",
      "color":"Red",
      "quantity":"1"
    }
    ,
    {
      "name":"Red dress",
      "bicture":"assets/images/products/dress1.jpeg",
      "old_price":120,
      "price":85,
      "size":"7",
      "color":"Red",
      "quantity":"1"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products_on_the_cart.length,
        itemBuilder: (BuildContext context,int index){
          return SingleCartProduct(
            cart_pro_name: products_on_the_cart[index]["name"],
            cart_pro_color: products_on_the_cart[index]["color"],
            cart_pro_picture: products_on_the_cart[index]["bicture"],
            cart_pro_price: products_on_the_cart[index]["price"],
            cart_pro_qty: products_on_the_cart[index]["quantity"],
            cart_pro_size: products_on_the_cart[index]["size"],
        );});
  }
}

