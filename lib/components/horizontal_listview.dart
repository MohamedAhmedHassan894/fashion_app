import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashionapp/modules/category.dart';
class HorizontalListCategories extends StatefulWidget {
  @override
  _HorizontalListCategoriesState createState() => _HorizontalListCategoriesState();
}

class _HorizontalListCategoriesState extends State<HorizontalListCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            imageLocation: 'assets/images/cats/tshirt.png',
            imageCaption: 'shirt',
          ),
          Category(
            imageLocation: 'assets/images/cats/jeans.png',
            imageCaption: 'pants',
          ),
          Category(
            imageLocation: 'assets/images/cats/informal.png',
            imageCaption: 'formal',
          ),
          Category(
            imageLocation: 'assets/images/cats/formal.png',
            imageCaption: 'formal',
          ),
          Category(
            imageLocation: 'assets/images/cats/dress.png',
            imageCaption: 'dress',
          ),
        ],
      )
    );
  }
}
