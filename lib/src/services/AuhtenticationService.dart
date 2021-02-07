import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  User getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    print("Test");
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print("Signed up");
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    print("Google");
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<http.Response> generateToken() async {
    var idToken = await this._firebaseAuth.currentUser.getIdToken(true);
    var url = 'http://localhost:3000/api/v1/sendToken';
    var response = await http.post(
      url,
      body: {'idToken': '$idToken'},
    );
    await updateIdToken();
    return response;
  }

  Future<http.Response> checkToken(String token) async {
    var idToken = await this._firebaseAuth.currentUser.getIdToken(true);
    var url = 'http://localhost:3000/api/v1/checkToken';
    var response = await http.post(
      url,
      body: {
        'idToken': '$idToken',
        'emailToken': '$token'
      },
    );
    await updateIdToken();
    return response;
  }

  Future<void> updateIdToken() async {
    await _firebaseAuth.currentUser.getIdToken(true);
  }

}