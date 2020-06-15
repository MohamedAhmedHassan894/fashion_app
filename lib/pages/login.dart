import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fashionapp/commons/loading.dart';
import 'package:fashionapp/pages/home_page.dart';
import 'package:fashionapp/pages/signup.dart';
import '../commons/common.dart';
import '../provider/user_provider.dart';
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading=false;
  bool isLoggedIn = false;

  void isSignedIn() async{
    setState(() {
      loading=true;
    });
    preferences = await SharedPreferences.getInstance();
    //this step check if user is signed in or not , it returnes true or false
    await _auth.currentUser().then((user){
      if(user!=null){
        setState(() {
          isLoggedIn=true;
        });
      }
    });
    if(isLoggedIn){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return HomePage();}));
    }
    //he is now signed in and no need to load any more , so i set loading to false
    setState(() {
      loading=false;
    });
  }
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<UserProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0.0,
      ),
      body:user.status==Status.Authenticating ? Loading() : Stack(
        children: <Widget>[
          Container(
            child: Padding(
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
                        SizedBox(height: 20,),
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
                                      return null;
                                    }
                                  },
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
                                    }else if(value.length<6){
                                      return 'The password has to be at least 6 characters long';
                                    }
                                    return null ;
                                  },
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
                            color:deepOrange,
                            elevation: 0.0,
                            child:MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async{
                                  if(_formKey.currentState.validate()) {
                                    if (!await user.signIn(
                                        _email.text, _password.text)) {
                                      _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                            content: Text("Sign in failed")),);
                                      return;
                                    }
                                    changeScreenReplacement(context, HomePage());

                                  }
                                },
                                child: Text("Login",textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Forgot Password",textAlign:TextAlign.center,style: TextStyle(fontWeight:FontWeight.w600,color: Colors.deepOrange),),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap:(){Navigator.push(context, MaterialPageRoute(builder: (context){return SignUp();}));},
                                      child: Text("Create an account",textAlign:TextAlign.center,style: TextStyle(fontWeight:FontWeight.w600,color: Colors.deepOrange),)),
                                ),
                              ),
                            ],
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
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(" Sign in with",style: TextStyle(fontSize: 20,color: grey),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  onPressed: (){},
                                  child: Image.asset("assets/images/ggg.png",width: 40,height: 40,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
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


}
