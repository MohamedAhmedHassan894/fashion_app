import 'package:flutter/material.dart';
import 'package:fashionapp/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AppProvider with ChangeNotifier{
  bool _isLoading = false;
  List<Product> _featuredProducts = List<Product>();
  AppProvider(){
    fetchProducts();
  }

  //getter
  List<Product> get featuredProducts =>List.from(_featuredProducts);

  bool get isLoading{
    return _isLoading ;
  }

  int get productLength{
    return featuredProducts.length;
  }

  Future<bool> fetchProducts() async{
    _isLoading = true;
    notifyListeners();
    try{
      final List<Product> productItems = [];
      QuerySnapshot x= await Firestore.instance.collection('products').getDocuments();
      for(int i=0;i<x.documents.length;i++){
        productItems.add(Product.fromSnapshot(x.documents[i]));
      }
      for(var item in productItems){
        if(item.featured==true){
          _featuredProducts.add(item);
        }else{
          print("no featured products");
        }
      }
      _isLoading=false;
      notifyListeners();
      return Future.value(true);
    }
    catch(error){
      _isLoading=false;
      notifyListeners();
      return Future.value(false);
    }
  }
}