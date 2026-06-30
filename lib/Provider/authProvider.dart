  import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pharmacymanagement/StateClass/Authstate.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() :super(AuthState());

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// ================= SIGN UP =================
  Future<String?> signUp({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final credential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      state = state.copyWith(
        user: credential.user,
        isLoading: false,
      );

      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return null;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return null;
    }
  }

  /// ================= LOGIN =================
  // Future<String?> login({
  //   required String email,
  //   required String password,
  //
  // }) async {
  //   try {
  //     state = state.copyWith(isLoading: true, error: null);
  //
  //     final credential =
  //     await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //
  //     final doc = await firestore
  //         .doc(credential.user!.uid)
  //         .get();
  //
  //     if (!doc.exists) {
  //       logout();
  //       return null;
  //     }
  //     state = state.copyWith(
  //       user: credential.user,
  //       isLoading: false,
  //     );
  //
  //     return credential.user?.uid;
  //   } on FirebaseAuthException catch (e) {
  //     state = state.copyWith(
  //       isLoading: false,
  //       error: e.message,
  //     );
  //     return null;
  //   } catch (e) {
  //     state = state.copyWith(
  //       isLoading: false,
  //       error: e.toString(),
  //     );
  //     return null;
  //   }
  // }
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      final credential =
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      state = state.copyWith(
        user: credential.user,
        isLoading: false,
      );

      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
      return null;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return null;
    }
  }

  /// ================= LOGOUT =================
  Future<void> logout() async {
    await _auth.signOut();
    state = AuthState(); // reset everything
  }
}
  final authProvider=StateNotifierProvider<AuthNotifier,AuthState>(
      (ref)=>AuthNotifier(),
  );