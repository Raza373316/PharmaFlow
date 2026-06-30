import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Modal/userModal.dart';
import '../StateClass/UserState.dart';


class UserNotifier extends StateNotifier<UserState> {
  UserNotifier() : super(const UserState());

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  /// Save User
  Future<void> saveUser(UserModel user) async {
    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      await _firestore
          .collection("users")
          .doc(user.uid)
          .set(user.toMap());

      state = state.copyWith(
        isLoading: false,
        user: user,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Fetch User
  Future<UserModel?> fetchUser(String uid) async {
    try {
      state = state.copyWith(
        isLoading: true,
        error: null,
      );

      final doc = await _firestore
          .collection("users")
          .doc(uid)
          .get();

      if (!doc.exists) {
        state = state.copyWith(
          isLoading: false,
        );
        return null;
      }

      final user = UserModel.fromMap(doc.data()!);

      state = state.copyWith(
        isLoading: false,
        user: user,
      );

      return user;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return null;
    }
  }
}

final userProvider =
StateNotifierProvider<UserNotifier, UserState>(
      (ref) => UserNotifier(),
);