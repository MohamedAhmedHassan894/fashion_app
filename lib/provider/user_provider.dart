import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
// the user can only be in one of those
// uninitialized means the user just opening the app , when he is unauthenticated we put him in the login screen because he needs authentication
// when he in authentication process , we need to show a circular progress indicator
// and when he authenticated it means the he is logged in
enum Status{Uninitialized,Authenticated,Authenticating,Unauthenticated}

class UserProvider with ChangeNotifier {
  bool _isLoading = false;
  String profileName = '';
  FirebaseAuth _auth;
  FirebaseUser _user;
  GoogleSignInAccount googleUser ;



  // this is the first status of the user
  Status _status = Status.Uninitialized;

  Status get status => _status;

  FirebaseUser get user => _user;
  Firestore _firestore = Firestore.instance;

  UserProvider.initialize() : _auth = FirebaseAuth.instance{
    // this will be just listening to the state of the user
    // so every time the state of the user change , onStatusChanged method will be called
    _auth.onAuthStateChanged.listen(_onStateChanged);
  }


  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password).then((user) {
        _firestore.collection('users').document(user.user.uid).setData({
          'name': name,
          'email': email,
          'userId': user.user.uid
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> googleSignIn() async {
    try{
      _status = Status.Authenticating;
      notifyListeners();
      final GoogleSignIn googleSignIn = GoogleSignIn();
      //we will sign this user in (googleUser) bellow
      GoogleSignInAccount googleUser = await googleSignIn.signIn();
      //and we will authenticate this user which we just signed in
      GoogleSignInAuthentication googleSignInAuthentication =await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken:googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
      FirebaseUser firebaseUser = (await _auth.signInWithCredential(credential)).user;
      if(credential!=null){
        //means if he exists ,
        // تحت هنا بنشوف لو اليوزر  idده بيساوي نفس اليوزر id  ال حصلنا عليه من الخطوة ال قبل if دي ولا لا
        final QuerySnapshot result = await Firestore .instance.collection('users').where('id',isEqualTo: firebaseUser.uid).getDocuments();
        final List<DocumentSnapshot> documents = result.documents;
        if(documents.length==0){
          //thats mean that user doesn't exists in our collection , and we don't have this user , so will insert him to our firebase collection
          //and insert the user to our collection
          Firestore.instance.collection('users').document(firebaseUser.uid).setData(
              {
                'name':firebaseUser.displayName,
                'email':firebaseUser.email,
                'userId':firebaseUser.uid
              }
          );
        }else{
        }
        //لو كل ده نجح بقا
        Fluttertoast.showToast(msg: "Login was Successful");
        notifyListeners();
        return true;
      }else{
        Fluttertoast.showToast(msg: "Login Failed :(");
        notifyListeners();
        return false;
      }
    }catch(e){
      print("hhhhhhhhhh$e");
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut ()async{
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    _auth.signOut();
     _status=Status.Unauthenticated;
     notifyListeners();
     return Future.delayed(Duration.zero);
  }

  Future<void> _onStateChanged(FirebaseUser user) async{
     if(user==null){
       _status=Status.Unauthenticated;
     }else{
       _user=user;
       _status=Status.Authenticated;
     }
     notifyListeners();
  }
  Future<bool>getProfileData() async {
    _isLoading = true;
    try {
      DocumentSnapshot ds=await Firestore.instance.collection('users').document(user.uid).get();
      profileName = ds.data['name'];
      return Future.value(true);
    }catch(error){
      _isLoading=false;
      return Future.value(false);
    }
  }

}
//here we manage the states of the app and ui is just a reflection