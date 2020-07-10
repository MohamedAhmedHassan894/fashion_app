import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashionapp/pages/home_page.dart';
import 'package:fashionapp/components/products.dart';
class ProductDetails extends StatefulWidget {
  final pro_detail_name;
  final pro_detail_price;
  final pro_detail_oldPrice;
  final pro_detail_picture;
  ProductDetails({this.pro_detail_name,this.pro_detail_price,this.pro_detail_oldPrice,this.pro_detail_picture});
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        backgroundColor: Colors.redAccent,
        title: InkWell(
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context){return HomePage();}));},
            child: Text("Fashion app")),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon:Icon(Icons.search), onPressed:(){}),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            color: Colors.white,
            child: GridTile(
              child: Container(
                child: Image.network(widget.pro_detail_picture),),
              footer :Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: Text(widget.pro_detail_name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                    title: Row(
                      children: <Widget>[
                        Expanded(child: Text("\$"+ widget.pro_detail_oldPrice.toString(),style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough,),)),
                        Expanded(child: Text("\$"+ widget.pro_detail_price.toString(),style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          Row(
            children: <Widget>[
              Expanded(
                  child: MaterialButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder:(BuildContext context){
                            return AlertDialog(
                              title: Text("Size"),
                              content: Text("choose the size"),
                              actions: <Widget>[
                                MaterialButton(
                                  onPressed: (){
                                    Navigator.of(context).pop(context);
                                  },
                                  child: Text("close",style: TextStyle(color: Colors.blue),),
                                ),
                              ],
                            );
                          }
                      );
                    },
                    elevation: .2,
                    textColor: Colors.grey,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(child: Text("size"),),
                        Expanded(child: Icon(Icons.arrow_drop_down)),
                      ],
                    ),
                  ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text("Colors"),
                          content: Text("choose the color"),
                          actions: <Widget>[
                            MaterialButton(
                                child: Text("close",style: TextStyle(color: Colors.blue),),
                                onPressed: (){Navigator.of(context).pop(context);}),
                          ],
                        );
                      }
                    );
                  },
                  elevation: .2,
                  textColor: Colors.grey,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text("color"),),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text("Quantity"),
                            content: Text("choose the quantity"),
                            actions: <Widget>[
                              MaterialButton(
                                  child: Text("close",style: TextStyle(color: Colors.blue),),
                                  onPressed: (){Navigator.of(context).pop(context);}),
                            ],
                          );
                        }
                    );
                  },
                  elevation: .2,
                  textColor: Colors.grey,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text("qty"),),
                      Expanded(child: Icon(Icons.arrow_drop_down)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child:  MaterialButton(
                    onPressed: (){},
                    elevation: .2,
                    textColor: Colors.white,
                    color: Colors.red,
                  child: Text("Buy now"),
              ),
              ),
              IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.red,),onPressed: (){},),
              IconButton(icon: Icon(Icons.favorite_border,color: Colors.red,),onPressed: (){},),
            ],
          ),
          Divider(),
          ListTile(
            title: Text("Product details"),
            subtitle: Text("dcbjbbbbbbbbbbbbbbbbbbbbbbbbdcsjbcsochbooooooooooooooooooooooooomlnolnooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooojnxodncccccccccccknnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnooooooooooooobbbbbbbbbbbdsibchsichbsi"),
          ),
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(12.0,5.0,5.0,5.0),
                child: Text("product name",style: TextStyle(color: Colors.grey),),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.pro_detail_name),),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0,5.0,5.0,5.0),
                child: Text("product brand",style: TextStyle(color: Colors.grey),),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("BRAND X"),),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(12.0,5.0,5.0,5.0),
                child: Text("product condition",style: TextStyle(color: Colors.grey),),

              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("NEW"),),
            ],
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("similar Products"),
          ),
          Container(
            height: 340.0,
            padding: EdgeInsets.all(8.0),
            child: Products(),
          ),
        ],
      ),
      
    );
  }
}
