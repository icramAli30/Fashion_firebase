import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_class/models/User_modelclass.dart';
import 'package:firebase_class/services/cloudnary_services.dart';
import 'package:image_picker/image_picker.dart';


class ProfileService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CloudniaryService cloudniaryService = CloudniaryService();

  CollectionReference<Map<String, dynamic>> get _userCollection =>
      _firebaseFirestore.collection('users');

  String? get _uid => _auth.currentUser?.uid;

  DocumentReference<Map<String, dynamic>> _userDoc(String uuid) {
    return _userCollection.doc(uuid);
  }

  Future<UserModel> getorCreateProfile() async {
    final uid = _uid;
    final email = _auth.currentUser?.email ?? '';

    if (uid == null) {
      throw Exception('No logged in user found');
    }

    final snapshot = await _userDoc(uid).get();

    if (snapshot.exists && snapshot.data() != null) {
      return UserModel.fromJson(snapshot.data()!);
    }

    final profile = UserModel.empty(email);
    await _userDoc(uid).set(profile.toJson());
    return profile;
  }

  Future<UserModel?> getprofile(String uuid) async {
    final snapshot = await _userDoc(uuid).get();

    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }

    return UserModel.fromJson(snapshot.data()!);
  }

  Future<void> createInitialprofile(String uuid, String email) async {
    final existingProfile = await getprofile(uuid);

    if (existingProfile != null) {
      return;
    }

    await _userDoc(uuid).set(UserModel.empty(email).toJson());
  }

  Future<void> updateProfile(
      UserModel userModel, {
        XFile? imageFile,
      }) async {

    final uid = _uid;

    if (uid == null) {
      throw Exception("User not found");
    }

    var updatedProfile = userModel;

    if (imageFile != null) {
      final imageUrl = await cloudniaryService.uploadImage(imageFile);

      updatedProfile = userModel.copyWith(
        image: imageUrl,
      );
    }

    await _userDoc(uid).set(
      updatedProfile.toJson(),
      SetOptions(merge: true),
    );
  }

  Stream<UserModel> getProfileStream() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map((doc) => UserModel.fromJson(doc.data()!));
  }
}
