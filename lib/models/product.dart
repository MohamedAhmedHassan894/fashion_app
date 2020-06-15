import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  //these constants are the names of data in firestore in products
  static const  NAME='name';
  static const  PRICE='price';
  static const  BRAND ='brand';
  static const  COLORS ='colors';
  static const  QUANTITY='quantity';
  static const  SIZES='sizes';
  static const  FEATURED = 'featured';
  static const  SALE='sale';
  static const  PICTURE = 'picture';
  static const  ID='id';
  static const  CATEGORY='category';



  //these variables will store the type of data in each field od products
  String _name;
  String _brand ;
  double _price;
  int _quantity;
  List _colors ;
  List _sizes;
  bool _sale;
  bool _featured ;
  String _picture;
  String _id;
  String _category;



  String get brand => _brand;
  String get name => _name;
  double get price => _price;
  int get quantity => _quantity;
  List get colors => _colors;
  List get size => _sizes;
  bool get featured => _featured;
  bool get sale => _sale;
  String get picture => _picture;
  String get id => _id;
  String get category => _category;


  Product.fromSnapshot(DocumentSnapshot snapshot){
    //snapshot is what we will get from our database , and put him in our private variables, and we will read these values using getters
    //so when we create an object from that class we will read the data from database and asign the data to these private variables
    Map data = snapshot.data;
    _featured = snapshot.data[FEATURED];
    _brand = snapshot.data[BRAND];
    _name=snapshot.data[NAME];
    _price=snapshot.data[PRICE];
    _colors=snapshot.data[COLORS];
    _sizes=snapshot.data[SIZES];
    _sale=snapshot.data[SALE];
    _quantity=snapshot.data[QUANTITY];
    _picture=snapshot.data[PICTURE];
    _id=snapshot.data[ID];
    _category=snapshot.data[CATEGORY];
  }


}