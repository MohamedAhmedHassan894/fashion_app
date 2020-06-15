import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:fashionapp/components/horizontal_listview.dart';
import '../components/products.dart';
import 'package:fashionapp/pages/cart.dart';
import 'package:fashionapp/provider/app_provider.dart';
import 'package:fashionapp/provider/user_provider.dart';
import '../commons/common.dart';
import '../pages/login.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Firestore auth = Firestore.instance;
  Widget image_carousel = Container(
    height: 200.0,
    child: Carousel(

      boxFit: BoxFit.cover,
      images: [
        AssetImage('assets/images/c1.jpg'),
        AssetImage('assets/images/m1.jpeg'),
        AssetImage('assets/images/w3.jpeg'),
        AssetImage('assets/images/w4.jpeg'),
        AssetImage('assets/images/m2.jpg'),
      ],
      autoplay: false,
     // animationCurve: Curves.fastOutSlowIn,
     // animationDuration: Duration(milliseconds: 10),
      indicatorBgPadding: 12.0,
      dotSize: 7,
      dotBgColor: Colors.transparent,
    ),
  );
  TextEditingController _searchController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<UserProvider>(context);
    user.getProfileData();
    AppProvider appProvider =Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: deepOrange),
        elevation: 0.2,
        backgroundColor: white,
        title: Material(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[50],
          elevation: 0.0,
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search...",
            ),
            controller: _searchController,
            // ignore: missing_return
            validator: (value) {
              if (value.isEmpty) {
                return 'The search field cannot ba empty ';
              }
              return null;
            },
          ),
        ),
        centerTitle: false,
        actions: <Widget>[
          IconButton(icon:Icon(Icons.search,color: deepOrange,), onPressed:(){}),
          IconButton(icon:Icon(Icons.shopping_cart,color: deepOrange,), onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (context){return Cart();}));
          }),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color:deepOrange,
              ),
              accountName: Text(user.profileName),
              accountEmail: Text(user.user.email.toString()),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person,color: Colors.white,),
              ),
            ),
            InkWell(
              child: ListTile(
                title: Text("Home Page"),
                leading: Icon(Icons.home,color: Colors.red,),
              ),
            ),
            InkWell(
              child: ListTile(
                title: Text("My Account"),
                leading: InkWell(
                  onTap: (){},
                    child: Icon(Icons.person,color: Colors.red,)),
              ),
            ),
            InkWell(
              child: ListTile(
                title: Text("My Order"),
                leading: Icon(Icons.shopping_basket,color: Colors.red,),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context){return Cart();}));
              },
              child: ListTile(
                title: Text("Shopping cart"),
                leading: Icon(Icons.shopping_cart,color: Colors.red,),
              ),
            ),
            InkWell(
              child: ListTile(
                title: Text("Favorites"),
                leading: Icon(Icons.favorite,color: Colors.red,),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){
                user.signOut();
                changeScreenReplacement(context, Login());
              },
              child: ListTile(
                title: Text("Log out"),
                leading: Icon(Icons.transit_enterexit,color: Colors.green,),
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          image_carousel,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0,vertical: 8.0),
            child:Container(alignment:Alignment.centerLeft,child: Text("Categories",
              style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400),)),
          ),
          HorizontalListCategories(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0,vertical: 8.0),
            child:Container(alignment:Alignment.centerLeft,child: Text("Recent Products",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w400),)),
          ),
          Flexible(
            //Text(appProvider.featuredProducts.length),
            child:Products(),
          ),
        ],
      ),
    );
  }

}
