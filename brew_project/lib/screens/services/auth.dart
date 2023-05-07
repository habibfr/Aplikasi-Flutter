import 'package:brew_project/models/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user based on uid
  MyUser? _userFromFirebaseUser(User user){
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // sign anonim
  Future signInAnonim() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}