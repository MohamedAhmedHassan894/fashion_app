import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SingleCartProduct extends StatelessWidget {
  final cart_pro_name,cart_pro_color,cart_pro_price,cart_pro_picture,cart_pro_qty,cart_pro_size;
  SingleCartProduct({
    this.cart_pro_color,
    this.cart_pro_picture,
    this.cart_pro_name,
    this.cart_pro_price,
    this.cart_pro_qty,
    this.cart_pro_size
});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Image.asset(cart_pro_picture,width: 100.0,height: 80.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(cart_pro_name,style: TextStyle(fontWeight: FontWeight.bold),),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Text("Size:"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(cart_pro_size,style: TextStyle(color: Colors.red),),
                        ),
                        //this section below for the product color//
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.0,8.0,8.0,8.0),
                          child: Text("Color:"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(cart_pro_color,style: TextStyle(color: Colors.red),),
                        )
                      ],
                    ),
                    //this section for the product color//
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text("\$$cart_pro_price",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,fontSize: 17.0),),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Column(
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){}),
                Text(cart_pro_qty),
                IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){}),
              ],
            ),
          ),
        ],
      ),

    );
  }
}
