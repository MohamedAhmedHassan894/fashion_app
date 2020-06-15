import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashionapp/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
 abstract class BaseAuth{
   Future<bool> googleSignIn();
 }

 class Auth implements BaseAuth{
   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<bool> googleSignIn() async{
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    SharedPreferences preferences;
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
          await preferences.setString('name',firebaseUser.displayName);
          await preferences.setString('email',firebaseUser.email);
          await preferences.setString('userId',firebaseUser.uid);
          //if this document dose not equal to zero , it means that that user exists , so we not gonna insert him to database
        }else{
          //هنخزنه بقا عن طريق ال  document ال معرفينه فوق
          await preferences.setString("name", documents[0]['name']);
          await preferences.setString("email", documents[0]['email']);
          await preferences.setString("userId", documents[0]['userId']);
        }
        //لو كل ده نجح بقا
        Fluttertoast.showToast(msg: "Login was Successful");
      return Future.value(true);
      }else{
        Fluttertoast.showToast(msg: "Login Failed :(");
        return Future.value(false);
      }
    }
  }