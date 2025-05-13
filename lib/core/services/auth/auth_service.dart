import 'dart:convert';
import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
      debugPrint("Google sign-in error: $e");
      return null;
    }
  }

  // Apple login Method
  Future<UserCredential?> signInWithApple() async {
    try {
      // Use proper platform check
      if (Platform.isIOS) {
        // iOS native flow - no need for webAuthenticationOptions
        print("Using iOS native Apple Sign In flow");
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
        );

        print("Apple credential obtained - checking audience");

        // Log token info to help debug audience issues
        if (appleCredential.identityToken != null) {
          try {
            final parts = appleCredential.identityToken!.split('.');
            if (parts.length > 1) {
              // Base64 decode and print the payload
              final payload =
                  parts[1].replaceAll('-', '+').replaceAll('_', '/');
              final normalized =
                  payload.padRight((payload.length + 3) & ~3, '=');
              final decodedBytes = base64Decode(normalized);
              final decodedPayload = String.fromCharCodes(decodedBytes);
              print("JWT payload: $decodedPayload");
            }
          } catch (e) {
            print("Error decoding token: $e");
          }
        }

        // Create Firebase credential
        final oAuthProvider = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );

        // Sign in with Firebase
        try {
          final userCredential =
              await _firebaseAuth.signInWithCredential(oAuthProvider);
          await createCustomerInFirestore(userCredential.user);
          return userCredential;
        } catch (firebaseError) {
          print("Firebase auth error: $firebaseError");
          rethrow;
        }
      } else {
        // Android/Web flow with webAuthenticationOptions
        print("Using Android/Web Apple Sign In flow");
        final appleCredential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'com.peasy.ios',
            redirectUri: Uri.parse(
                'https://peasy-8f59e.firebaseapp.com/__/auth/handler'),
          ),
        );

        // Same token debugging as above
        print("Apple credential obtained - checking audience");
        if (appleCredential.identityToken != null) {
          try {
            final parts = appleCredential.identityToken!.split('.');
            if (parts.length > 1) {
              final payload =
                  parts[1].replaceAll('-', '+').replaceAll('_', '/');
              final normalized =
                  payload.padRight((payload.length + 3) & ~3, '=');
              final decodedBytes = base64Decode(normalized);
              final decodedPayload = String.fromCharCodes(decodedBytes);
              print("JWT payload: $decodedPayload");
            }
          } catch (e) {
            print("Error decoding token: $e");
          }
        }

        final oAuthProvider = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          accessToken: appleCredential.authorizationCode,
        );

        try {
          final userCredential =
              await _firebaseAuth.signInWithCredential(oAuthProvider);
          await createCustomerInFirestore(userCredential.user);
          return userCredential;
        } catch (firebaseError) {
          print("Firebase auth error: $firebaseError");
          rethrow;
        }
      }
    } catch (e) {
      print("Error Sign in with Apple: $e");
      return null;
    }
  }

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
