import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashionapp/pages/product_details.dart';
import '../commons/common.dart';
class SingleProduct extends StatelessWidget {
  final pro_name;
  final pro_price;
  final pro_oldPrice;
  final pro_picture;

  SingleProduct(
      {this.pro_name, this.pro_price, this.pro_oldPrice, this.pro_picture});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProductDetails(
              pro_detail_name: pro_name,
              pro_detail_oldPrice: pro_oldPrice,
              pro_detail_picture: pro_picture,
              pro_detail_price: pro_price,
            );
          }));
        },
        child: Card(
          elevation: 5.0,
          child: Stack(
            children: <Widget>[
              Container(child: Image.network(pro_picture,fit: BoxFit.fill,width: MediaQuery.of(context).size.width,)),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white60, Colors.white70],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: ListTile(
                    leading: Text(
                      pro_name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(
                      "\$ $pro_price",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,fontSize: 20, color:deepOrange),
                    ),
                    subtitle: Text(
                      "\$ $pro_oldPrice",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.black54,
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
