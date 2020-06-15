import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashionapp/components/cart_products.dart';
class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.redAccent,
        title: Text("Cart"),
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon:Icon(Icons.search), onPressed:(){}),
        ],
      ),
      bottomNavigationBar:
      Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
                  title: Text("Total"),
                  subtitle: Text("\$170"),
                ),),
            Expanded(
              child: MaterialButton(
                color: Colors.red,
                onPressed: (){},
                child: Text("Check out",style: TextStyle(color: Colors.white,),),
                  ),
            ),
          ],
        ),
      ),
      body: CartProducts(),
    );
  }
}
