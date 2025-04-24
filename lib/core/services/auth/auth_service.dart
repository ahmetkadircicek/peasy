import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Instantiate FirebaseAuth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get the current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Google sign in
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Begin interactive sign-in process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // User cancels google sign in pop up screen
      if (googleUser == null) {
        return null;
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
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      // Kullanıcıyı Firestore'a ekle
      await createCustomerInFirestore(userCredential.user);

      return userCredential;
    } catch (e) {
      print("Google sign-in error: $e");
      return null;
    }
  }

  // Apple login Method
  // Future<UserCredential?> signInWithApple() async {
  //   try {
  //     final appleCredential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );

  //     final oAuthProvider = OAuthProvider("apple.com").credential(
  //       idToken: appleCredential.identityToken,
  //       accessToken: appleCredential.authorizationCode,
  //     );
  //     return await _firebaseAuth.signInWithCredential(oAuthProvider);
  //   } catch (e) {
  //     print("Error Sign in with Apple: $e");
  //     return null;
  //   }
  // }

  // Firestore user data
  Future<void> createCustomerInFirestore(User? user) async {
    final userDoc = _firestore.collection("Customers").doc(currentUser!.uid);

    final userSnapshot = await userDoc.get();
    if (!userSnapshot.exists) {
      await userDoc.set({
        "uid": currentUser!.uid,
        "email": currentUser!.email,
        "displayName": currentUser!.displayName,
        "photoURL": currentUser!.photoURL,
        "createdAt": FieldValue.serverTimestamp(),
        "cardInfo": [
          {
            "cardNumber": "12345678901234567",
            "cardHolderName": "Oguzhan",
            "expiryDate": "12/25",
            "cvv": "112",
          },
        ],
        "orderHistory": [],
      });
    }
  }
}
