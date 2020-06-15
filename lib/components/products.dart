import 'package:fashionapp/provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:fashionapp/modules/single_product.dart';
import 'package:provider/provider.dart';
class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider =Provider.of<AppProvider>(context);
    return RefreshIndicator(
      onRefresh: appProvider.fetchProducts,
      child: GridView.builder(
          itemCount: appProvider.productLength,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context,int index){
            return Padding(
              padding: EdgeInsets.all(4.0,),
              child: SingleProduct(
                pro_name:appProvider.featuredProducts[index].name,
                pro_picture:appProvider.featuredProducts[index].picture,
                pro_price: appProvider.featuredProducts[index].price,
                pro_oldPrice: "100",
              ),
            );
          }),
    );
  }
}
