import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fashionapp/commons/loading.dart';
import 'package:fashionapp/provider/user_provider.dart';
import '../commons/common.dart';
import 'home_page.dart';
import '../db/auth.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String gender ;
  String groubValue ;
  bool hidePassword=true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email= TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  //shared preferences used to store the value whether the use used the app before or not
  // , it's a local database , store data in somewhere in the device
  SharedPreferences preferences;
  bool loading=false;
  Auth auth=Auth();
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<UserProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(backgroundColor: Colors.white24,elevation: 0.0,),
      body: user.status==Status.Authenticating ? Loading() : Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0,right:20.0,top: 5,bottom: 60),
            child: Container(
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color:Colors.grey[350],
                    blurRadius: 20.0
                  ),
                ],
              ),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height:20),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: Image.asset("assets/images/cart.png",width: 120),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(12.0),
                          color: grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Full name",
                                  icon: Icon(Icons.person_outline),
                                ),
                                controller: _name,
                                // ignore: missing_return
                                validator: (value){
                                  if(value.isEmpty) {
                                    return 'The name field cannot ba empty ';
                                  }
                                },
                                onSaved: (val)=>_name.text=val,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(12.0),
                          color: grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email ",
                                  icon: Icon(Icons.alternate_email),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                controller: _email,
                                // ignore: missing_return
                                validator: (value){
                                  if(value.isEmpty){
                                    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                    RegExp regex = RegExp(pattern);
                                    if(!regex.hasMatch(value)){
                                      return 'please make sure your email address is valid';
                                    }
                                  }
                                },
                                onSaved: (val)=>_email.text=val,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(12.0),
                          color: grey.withOpacity(0.2),
                          elevation: 0.0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 12.0),
                            child: ListTile(
                              title: TextFormField(
                                obscureText: hidePassword,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  icon: Icon(Icons.lock_outline),
                                ),
                                controller: _password,
                                // ignore: missing_return
                                validator: (value){
                                  if(value.isEmpty){
                                    return 'The password field cannot ba empty ';
                                  }if(value.length<6){
                                    return 'The password has to be at least 6 characters long';
                                  }
                                },
                                onSaved: (val)=>_password.text=val,
                              ),
                              trailing: IconButton(icon: Icon(Icons.remove_red_eye,size: 19.0,), onPressed: (){
                                setState(() {
                                  hidePassword=!hidePassword;
                                });
                              }),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: deepOrange,
                          elevation: 0.0,
                          child:MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async{
                                if(_formKey.currentState.validate()) {
                                  if (!await user.signUp(
                                      _name.text, _email.text,
                                      _password.text)) {
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                            content: Text("Sign up failed")));
                                    return;
                                  }
                                  changeScreenReplacement(context, HomePage());
                                }
                              },
                              child: Text("Sign up",textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child:InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                            child: Text("I already have an account",textAlign:TextAlign.center,style: TextStyle(fontSize:16.0,color: Colors.deepOrange,),),
                        ),
                      ),
                      Padding(
                        padding:const EdgeInsets.all(16.0),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(),
                            ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),

                              child: Text("Or",textAlign:TextAlign.center,style: TextStyle(fontSize:20.0,color: Colors.grey,),)
                          ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(
                                color: black,
                              ),
                            ),
                          ]
                        ) ,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(" Sign up with",style: TextStyle(fontSize: 20,color: grey),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                            child: Material(
                              child: MaterialButton(
                                onPressed: ()async{
                                  if(!_formKey.currentState.validate()) {
                                    if (!await user.googleSignIn()){
                                      _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                              content: Text("Sign up failed")));
                                      return;
                                    }
                                    changeScreenReplacement(context, HomePage());
                                  }
                                },
                                child: Image.asset("assets/images/ggg.png",width: 40,height: 40,),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
          Visibility(
            visible: loading??true,
            child: Container(
              alignment: Alignment.center,
              color: white.withOpacity(0.9),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(red),
              ),
            ),),
        ],
      ),
    );
  }

  valueChanged(e) {
    setState(() {
      if (e=="male"){
        groubValue=e;
        gender=e;
      }else if(e=="female"){
        groubValue=e;
        gender=e;
      }
    });
   }

}

