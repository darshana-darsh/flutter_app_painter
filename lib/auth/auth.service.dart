

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_app/preferences/UserPreferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService  {
  @override
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  SharedPreferences prefs;
  final databaseReference = Firestore.instance;




  // final FirebaseAuth _auth = FirebaseAuth.instance;
 // final FacebookLogin facebookSignIn = new FacebookLogin();

  Stream<FirebaseUser> onAuthChanged() {
    return _firebaseAuth.onAuthStateChanged;
  }

  Future<String> signInWithEmailAndPassword(String email,
      String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);


    UserPreference().setUserId(result.user.uid);
    print("userId----------"+result.user.uid);
    return result.user.uid;
  }

  Future<String> signInWithGoogle() async {
    print("hello google---------");
    await _googleSignIn.signOut();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    FirebaseUser user = await _firebaseAuth.currentUser();
    print("userId---------------"+ user.uid);
    if (user != null) {
      // Check is already sign up
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: user.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      UserPreference.setLoginStatus(true);
      print("documents---------------"+ documents.length.toString());
      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance
            .collection('users')
            .document(user.uid)
            .setData({
          'nickname': user.displayName,
          'photoUrl': user.photoUrl,
          'id': user.uid,
          'createdAt': DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
          'chattingWith': null
        });

        // Write data to local


        await prefs.setString('id', user.uid);
        await prefs.setString('nickname', user.displayName);
        await prefs.setString('photoUrl', user.photoUrl);
      } else {
        // Write data to local
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('nickname', documents[0]['nickname']);
        await prefs.setString('photoUrl', documents[0]['photoUrl']);
        await prefs.setString('aboutMe', documents[0]['aboutMe']);
      }


      return user.uid;
    }
  }

  /*Future<String> signInFacebook() async {
    print(
        "facebookk--------------------------------------------------------------------");
    //await facebookSignIn.logOut();
    final FacebookLoginResult result =
    await facebookSignIn.logInWithReadPermissions(['email']);
    print("token------" + result.accessToken.token);

    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: result.accessToken.token.toString(),

    );
    print("credential------" + credential.toString());
    AuthResult authResult = await _firebaseAuth.signInWithCredential(
        credential);
    //  final FirebaseUser user = authResult.user;
    //Token: ${accessToken.token}
    //  print(authResult);
    final FirebaseUser user = await _firebaseAuth.currentUser();
    final uid = user.uid;
    print(uid);
    return uid;
  }*/

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> signUp(String email,
      String password,
        String username,
      ) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,

    );
   await databaseReference.collection("Users").document(result.user.uid).setData({
      "email":email,
      "password":password,
      "username":username,
       "id":result.user.uid,
    });
    UserPreference().setUserId(result.user.uid);

      return result.user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<String> getAccessToken() async {
    FirebaseUser user = await getCurrentUser();
    IdTokenResult tokenResult = await user.getIdToken();
    return tokenResult.token;
  }

  Future<String> getRefreshToken() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    IdTokenResult tokenResult = await user.getIdToken(refresh: true);
    return tokenResult.token;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),

    ]);
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  @override
  Future<void> changeEmail(String email) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.updateEmail(email);
  }

  @override
  Future<void> changePassword(String password) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.updatePassword(password).then((_) {
      print("Succesfull changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
    return null;
  }

  @override
  Future<void> deleteUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.delete().then((_) {
      print("Succesfull user deleted");
    }).catchError((error) {
      print("user can't be delete" + error.toString());
    });
    return null;
  }

  @override
  Future<void> sendPasswordResetMail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return null;
  }
}

/*
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  SharedPreferences prefs;


  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookLogin facebookSignIn = new FacebookLogin();

  Stream<FirebaseUser> onAuthChanged() {
    return _firebaseAuth.onAuthStateChanged;
  }

  Future<String> signInWithEmailAndPassword(String email,
      String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return result.user.uid;
  }

  Future<String> signInWithGoogle(setState()) async {
    await _googleSignIn.signOut();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    FirebaseUser user = await _firebaseAuth.currentUser();
    if (user != null) {
      // Check is already sign up
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: user.uid).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance
            .collection('users')
            .document(user.uid)
            .setData({
          'nickname': user.displayName,
          'photoUrl': user.photoUrl,
          'id': user.uid,
          'createdAt': DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
          'chattingWith': null
        });

        // Write data to local
        print( user.uid);
        await prefs.setString('id', user.uid);
        await prefs.setString('nickname', user.displayName);
        await prefs.setString('photoUrl', user.photoUrl);
      } else {
        // Write data to local
        await prefs.setString('id', documents[0]['id']);
        await prefs.setString('nickname', documents[0]['nickname']);
        await prefs.setString('photoUrl', documents[0]['photoUrl']);
        await prefs.setString('aboutMe', documents[0]['aboutMe']);
      }
      print(user.uid);

      return user.uid;
    }
  }

  Future<String> signInFacebook() async {
    print(
        "facebookk--------------------------------------------------------------------");
    //await facebookSignIn.logOut();
    final FacebookLoginResult result =
    await facebookSignIn.logInWithReadPermissions(['email']);
    print("token------" + result.accessToken.token);

    final AuthCredential credential = FacebookAuthProvider.getCredential(
      accessToken: result.accessToken.token.toString(),

    );
    print("credential------" + credential.toString());
    AuthResult authResult = await _firebaseAuth.signInWithCredential(
        credential);
    //  final FirebaseUser user = authResult.user;
    //Token: ${accessToken.token}
    //  print(authResult);
    final FirebaseUser user = await _firebaseAuth.currentUser();
    final uid = user.uid;
    print(uid);
    return uid;
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> signUp(String email,
      String password, {
        String username,
      }) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return result.user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<String> getAccessToken() async {
    FirebaseUser user = await getCurrentUser();
    IdTokenResult tokenResult = await user.getIdToken();
    return tokenResult.token;
  }

  Future<String> getRefreshToken() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    IdTokenResult tokenResult = await user.getIdToken(refresh: true);
    return tokenResult.token;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  @override
  Future<void> changeEmail(String email) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.updateEmail(email);
  }

  @override
  Future<void> changePassword(String password) async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.updatePassword(password).then((_) {
      print("Succesfull changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
    return null;
  }

  @override
  Future<void> deleteUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.delete().then((_) {
      print("Succesfull user deleted");
    }).catchError((error) {
      print("user can't be delete" + error.toString());
    });
    return null;
  }

  @override
  Future<void> sendPasswordResetMail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return null;
  }
}*/
