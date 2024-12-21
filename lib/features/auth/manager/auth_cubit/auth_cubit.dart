import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        emit(LoginFailure(errMsg: 'No user found for that email.'));
      } else if (e.code == 'invalid-credential') {
        emit(LoginFailure(errMsg: 'Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(LoginFailure(errMsg: e.toString()));
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(RegisterLoading());
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errMsg: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(
            errMsg: 'The account already exists for that email.'));
      } else if (e.code == 'invalid-email') {
        emit(RegisterFailure(errMsg: 'The email address is not valid.'));
      } else {
        emit(
            RegisterFailure(errMsg: e.message ?? 'An unknown error occurred.'));
      }
    } catch (e) {
      emit(RegisterFailure(errMsg: e.toString()));
    }
  }

  Future<String?> getUsername() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists && userDoc.data() != null) {
          return (userDoc.data() as Map<String, dynamic>)['username']
              ?.toString();
        } else {
          log("User document does not exist.");
        }
      }
    } catch (e) {
      log("Error getting username: $e");
    }
    return null;
  }
}
