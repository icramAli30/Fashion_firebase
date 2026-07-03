import 'dart:io';


import 'package:firebase_class/const/all_colors.dart';
import 'package:firebase_class/models/User_modelclass.dart';
import 'package:firebase_class/services/firebase_auth_services.dart';
import 'package:firebase_class/services/profile_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController bankaccountNameController =
  TextEditingController();
  final TextEditingController accountHolderNameController =
  TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();

  final FirebaseAuthServices firebaseAuthServices = FirebaseAuthServices();

  final ProfileService profileService = ProfileService();

  final ImagePicker imagePicker = ImagePicker();

  UserModel? userModel;

  File? selectedImage;

  bool isloading = true;
  bool isSaving = false;

  fillController(UserModel profile) {
    emailController.text = profile.email;
    pinCodeController.text = profile.pinCode;
    addressController.text = profile.address;
    cityController.text = profile.city;
    stateController.text = profile.state;
    countryController.text = profile.country;
    bankaccountNameController.text = profile.bankNumber;
    accountHolderNameController.text = profile.accountName;
    ifscCodeController.text = profile.ific;
  }

  Future loadProfile() async {
    try {
      final userProfile = await profileService.getorCreateProfile();

      fillController(userProfile);
      if (mounted) {
        setState(() {
          userModel = userProfile;
          isloading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile load failed: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future pickImage() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );

    if (pickedFile == null) return;

    setState(() {
      selectedImage = File(pickedFile.path);
    });
  }

  Future saveProfile() async {
    if (userModel == null) return;

    setState(() {
      isSaving = true;
    });

    try {
      final updatedProdile = userModel!.copyWith(
        email: emailController.text
            .trim()
            .isNotEmpty
            ? emailController.text.trim()
            : userModel!.email,
        pinCode: pinCodeController.text.trim(),
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        country: countryController.text.trim(),
        bankNumber: bankaccountNameController.text.trim(),
        accountName: accountHolderNameController.text.trim(),
        ific: ifscCodeController.text.trim(),
      );

      await profileService.updateProfile(
        updatedProdile,
        imageFile: selectedImage,
      );

      final refreshProfile = await profileService.getorCreateProfile();

      if (!mounted) return;

      setState(() {
        userModel = refreshProfile;
        selectedImage = null;
        isSaving = false;
      });

      fillController(refreshProfile);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Update failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = userModel?.image ?? '';

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,

      appBar: AppBar(title: const Text('My Profile')),
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
        child: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: pickImage,
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: const Color(0xFFF3F3F3),
                      backgroundImage: selectedImage != null
                          ? FileImage(selectedImage!)
                          : imageUrl.isNotEmpty
                          ? NetworkImage(imageUrl)
                          : null,
                      child: selectedImage == null && imageUrl.isEmpty
                          ? const Icon(Icons.person, size: 50)
                          : null,
                    ),
                  ],
                ),
              ),

              _buildTextField(emailController, "Enter your email"),
              _buildTextField(pinCodeController, "Enter your Pin code "),
              _buildTextField(addressController, "Enter your Address"),
              _buildTextField(cityController, "Enter your City"),
              _buildTextField(stateController, "Enter your State"),
              _buildTextField(countryController, "Enter your Country"),
              _buildTextField(
                bankaccountNameController,
                "Enter your Bank Account Number",
              ),
              _buildTextField(
                accountHolderNameController,
                "Enter your Account Holder Name",
              ),
              _buildTextField(
                ifscCodeController,
                "Enter your Account Holder IFSC Code",
              ),

              isSaving
                  ? const Padding(
                padding: EdgeInsets.only(bottom: 28),
                child: CircularProgressIndicator(),
              )
                  : GestureDetector(
                onTap: saveProfile,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 28.0,
                    right: 28,
                    bottom: 28,
                  ),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      'Save Profile',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller,
      String hint,) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:TextStyle(
            color:AllColors.secondaryColors,
            fontSize:18,
          ),

          filled: true,
          fillColor:AllColors.whiteColors,

          contentPadding:EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AllColors.broderColors,
              width: 1.5,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:  BorderSide(
              color:AllColors.primaryColors,
              width: 2,
            ),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}