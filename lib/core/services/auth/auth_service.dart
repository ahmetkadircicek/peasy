import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Instantiate FirebaseAuth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Get the current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Google sign in
  signInWithGoogle() async {
    // Begin interactive sign-in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // User cancels google sign in pop up screen
    if (googleUser == null) {
      return;
    }

    // Obtain auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in the user with the credential
    return await _firebaseAuth.signInWithCredential(credential);
  }
}
