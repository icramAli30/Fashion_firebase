import 'dart:io';

import 'package:firebase_class/const/all_colors.dart';
import 'package:firebase_class/models/User_modelclass.dart';
import 'package:firebase_class/services/firebase_auth_services.dart';
import 'package:firebase_class/services/profile_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

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
  XFile? selectedImage;
  bool isLoading = true;
  bool isSaving = false;

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    emailController.dispose();
    pinCodeController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    bankaccountNameController.dispose();
    accountHolderNameController.dispose();
    ifscCodeController.dispose();
  }

  void fillController(UserModel profile) {
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

  Future<void> loadProfile() async {
    try {
      final userProfile = await profileService.getorCreateProfile();
      fillController(userProfile);
      if (mounted) {
        setState(() {
          userModel = userProfile;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
        _showSnackBar('Profile load failed: $e', isError: true);
      }
    }
  }

  Future<void> pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.purple),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 70,
                );
                if (pickedFile != null) {
                  setState(() {
                    selectedImage = pickedFile;
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.purple),
              title: const Text('Take a Photo'),
              onTap: () async {
                Navigator.pop(context);
                final pickedFile = await imagePicker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 70,
                );
                if (pickedFile != null) {
                  setState(() {
                    selectedImage = pickedFile;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    if (userModel == null) return;

    setState(() => isSaving = true);

    try {
      final updatedProfile = userModel!.copyWith(
        email: emailController.text.trim().isNotEmpty
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
        updatedProfile,
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
      _showSnackBar('Profile updated successfully!');
    } catch (e) {
      if (!mounted) return;
      setState(() => isSaving = false);
      _showSnackBar('Update failed: $e', isError: true);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // Validation methods
  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePincode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your pincode';
    }
    if (value.trim().length < 4 || value.trim().length > 10) {
      return 'Pincode should be 4-10 digits';
    }
    return null;
  }

  String? _validateIfsc(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter IFSC code';
    }
    if (value.trim().length != 11) {
      return 'IFSC code must be 11 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = userModel?.image ?? '';

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AllColors.primaryColors,
        elevation: 0,
        centerTitle: true,
        actions: [
          if (!isLoading)
            IconButton(
              icon: const Icon(Icons.refresh, color: Colors.white),
              onPressed: loadProfile,
            ),
        ],
      ),
      body: isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading profile...', style: TextStyle(fontSize: 16)),
          ],
        ),
      )
          : SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Profile Image Section
                _buildProfileImageSection(imageUrl),

                const SizedBox(height: 24),

                // Form Fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildTextField(
                        emailController,
                        "Email Address",
                        "Enter your email",
                        validator: _validateEmail,
                        enabled: false, // Email is usually read-only
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(height: 12),

                      _buildTextField(
                        pinCodeController,
                        "Pincode",
                        "Enter your pincode",
                        validator: _validatePincode,
                        prefixIcon: Icons.pin_drop,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),

                      _buildTextField(
                        addressController,
                        "Address",
                        "Enter your address",
                        validator: (v) => _validateRequired(v, 'address'),
                        prefixIcon: Icons.home,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 12),

                      _buildTextField(
                        cityController,
                        "City",
                        "Enter your city",
                        validator: (v) => _validateRequired(v, 'city'),
                        prefixIcon: Icons.location_city,
                      ),
                      const SizedBox(height: 12),

                      _buildTextField(
                        stateController,
                        "State",
                        "Enter your state",
                        validator: (v) => _validateRequired(v, 'state'),
                        prefixIcon: Icons.map,
                      ),
                      const SizedBox(height: 12),

                      _buildTextField(
                        countryController,
                        "Country",
                        "Enter your country",
                        validator: (v) => _validateRequired(v, 'country'),
                        prefixIcon: Icons.flag,
                      ),
                      const SizedBox(height: 12),

                      // Divider for Bank Details
                      _buildSectionDivider('Bank Details'),
                      const SizedBox(height: 12),

                      _buildTextField(
                        bankaccountNameController,
                        "Bank Account Number",
                        "Enter your bank account number",
                        validator: (v) =>
                            _validateRequired(v, 'bank account number'),
                        prefixIcon: Icons.account_balance,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 12),

                      _buildTextField(
                        accountHolderNameController,
                        "Account Holder Name",
                        "Enter account holder name",
                        validator: (v) =>
                            _validateRequired(v, 'account holder name'),
                        prefixIcon: Icons.person,
                      ),
                      const SizedBox(height: 12),

                      _buildTextField(
                        ifscCodeController,
                        "IFSC Code",
                        "Enter IFSC code",
                        validator: _validateIfsc,
                        prefixIcon: Icons.code,
                        keyboardType: TextInputType.text,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Save Button
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImageSection(String imageUrl) {
    return GestureDetector(
      onTap: pickImage,
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: AllColors.primaryColors.withOpacity(0.1),
                backgroundImage: imageUrl.isNotEmpty && selectedImage == null
                    ? NetworkImage(imageUrl)
                    : null,
                child: selectedImage != null
                    ? FutureBuilder<Uint8List>(
                  future: selectedImage!.readAsBytes(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }

                    return ClipOval(
                      child: Image.memory(
                        snapshot.data!,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                )
                    : imageUrl.isEmpty
                    ? Icon(
                  Icons.person,
                  size: 60,
                  color: AllColors.primaryColors.withOpacity(0.5),
                )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AllColors.primaryColors,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Tap to change photo',
            style: TextStyle(
              color: AllColors.primaryColors,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      String hint, {
        String? Function(String?)? validator,
        IconData? prefixIcon,
        TextInputType? keyboardType,
        int maxLines = 1,
        bool enabled = true,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: AllColors.primaryColors)
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AllColors.primaryColors,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red.shade400,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red.shade400,
                width: 2,
              ),
            ),
            errorStyle: const TextStyle(fontSize: 12),
          ),
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          enabled: enabled,
        ),
      ],
    );
  }

  Widget _buildSectionDivider(String title) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: TextStyle(
              color: AllColors.primaryColors,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: isSaving ? null : saveProfile,
          style: ElevatedButton.styleFrom(
            backgroundColor: AllColors.primaryColors,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            disabledBackgroundColor: AllColors.primaryColors.withOpacity(0.6),
          ),
          child: isSaving
              ? const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.5,
            ),
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.save, size: 22),
              SizedBox(width: 10),
              Text(
                'Save Profile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}