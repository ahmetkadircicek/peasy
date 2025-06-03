import 'dart:convert';
import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(); // Tek bir örnek oluştur

  User? get currentUser => _firebaseAuth.currentUser;

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    return await _firebaseAuth.signOut();
  }

  Future<UserCredential?> loginWithGoogle() async {
    try {
      // Sessiz oturum açmayı dene (isteğe bağlı UX iyileştirmesi)
      GoogleSignInAccount? googleUser =
          await _googleSignIn.signInSilently() ?? await _googleSignIn.signIn();

      if (googleUser == null) {
        debugPrint("Google kullanıcı iptal etti.");
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      await createCustomerInFirestore(userCredential.user);

      return userCredential;
    } catch (e, stack) {
      debugPrint("Google sign-in error: $e\n$stack");
      return null;
    }
  }

  Future<UserCredential?> loginWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: Platform.isIOS
            ? null
            : WebAuthenticationOptions(
                clientId: 'com.peasy.ios',
                redirectUri: Uri.parse(
                    'https://peasy-8f59e.firebaseapp.com/__/auth/handler'),
              ),
      );

      // (isteğe bağlı) JWT çözümleme
      _logJwtPayload(appleCredential.identityToken);

      final oAuthProvider = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(oAuthProvider);

      await createCustomerInFirestore(userCredential.user);
      return userCredential;
    } catch (e, stack) {
      debugPrint("Apple sign-in error: $e\n$stack");
      return null;
    }
  }

  Future<void> createCustomerInFirestore(User? user) async {
    if (user == null) return;

    final userDoc = _firestore.collection("Customers").doc(user.uid);
    final userSnapshot = await userDoc.get();

    if (!userSnapshot.exists) {
      await userDoc.set({
        "customerId": user.uid,
        "email": user.email,
        "displayName": user.displayName,
        "photoURL": user.photoURL,
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

  void _logJwtPayload(String? token) {
    if (token == null) return;

    try {
      final parts = token.split('.');
      if (parts.length > 1) {
        final payload = parts[1].replaceAll('-', '+').replaceAll('_', '/');
        final normalized = payload.padRight((payload.length + 3) & ~3, '=');
        final decodedBytes = base64Decode(normalized);
        final decodedPayload = String.fromCharCodes(decodedBytes);
        debugPrint("JWT payload: $decodedPayload");
      }
    } catch (e) {
      debugPrint("JWT çözümleme hatası: $e");
    }
  }
}
