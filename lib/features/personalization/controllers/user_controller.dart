import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/data/repositories/authentication/authentication_repository.dart';
import 'package:i_store/data/repositories/user/user_repository.dart';
import 'package:i_store/features/authentication/screens/login_screen.dart';
import 'package:i_store/features/personalization/models/user_model.dart';
import 'package:i_store/features/personalization/screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/network_manager.dart';
import 'package:i_store/utils/popups/full_screen_loader.dart';
import 'package:i_store/utils/popups/loaders.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;

  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();
  final hidePassword = false.obs;
  final imageUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
   try {
     profileLoading.value = true;
     final userData = await userRepository.fetchUserDetails();
     user(userData);
     profileLoading.value = false;
   }
   catch (e) {
   user(UserModel.empty());
   }
   finally {
     profileLoading.value = false;
   }
  }

  ///Save user record from any Registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      //First Update Rx User and check if user data is already stored. if not stored new data
      await fetchUserRecord();

      //If no record already stored
      if(user.value.id.isEmpty) {
        if(userCredentials != null){
          //Convert Name to First and Last Name
          final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(userCredentials.user!.displayName ?? '');

          //Map Data
          final user = UserModel(
              id: userCredentials.user!.uid,
              firstName: nameParts[0],
              lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
              username: username,
              email: userCredentials.user!.email ?? '',
              phoneNumber: userCredentials.user!.phoneNumber ?? '',
              profilePicture: userCredentials.user!.photoURL ?? ''
          );

          //Save user data
          await userRepository.saveUserRecord(user);
        }
      }

    }
    catch (e){
      TLoaders.warningSnackBar(
          title: 'Data not saved',
        message: 'Something went wrong while saving your information. You can re-save your data in your Profile.'
      );
    }
  }

  ///Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(TSizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, side: const BorderSide(color: Colors.red)),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
            child: Text('Delete'),
          )
      ),
      cancel: OutlinedButton(
          onPressed: () => Navigator.of(Get.overlayContext!).pop(),
          child: const Text('Cancel')
      )
    );
  }

  ///Delete user account
  void deleteUserAccount() async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Processing...', TImages.docerAnimation);

      ///First re-authenticate user
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData.map((e) => e.providerId).first;
      if(provider.isNotEmpty){
        //Re Verify Auth Email
        if (provider == 'google.com'){
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        }
        else if (provider == 'password'){
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const ReAuthLoginForm());
        }
      }
    }
    catch (e){
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  ///Re-Authenticate before deleting
  reAuthenticateEmailAndPasswordUser() async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Processing...', TImages.docerAnimation);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      if(!reAuthFormKey.currentState!.validate()) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.reAuthenticateWithEmailAndPassword(verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();

      TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    }
    catch (e){
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  //Upload Profile Image using file_picker
  ///import 'package:file_picker/file_picker.dart';
  /* uploadUserProfilePicture() async {
    try {
      //final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png'], // Add any other allowed file extensions here
      );
      if(result != null){
        final file = result.files.single;
        imageUploading.value = true;
        //Upload file
        final fileUrl = await userRepository.uploadImage('Users/Images/Profile/', file);

        //Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture' : fileUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = fileUrl;
        user.refresh();
        //Show success message
        TLoaders.successSnackBar(title: 'Successfully', message: 'Your Profile Image has been updated.');
      }
    }
    catch (e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Something went wrong : $e');
    }
    finally {
      imageUploading.value = false;
    }
  } */

  //Upload Profile Image using image_picker
  //import 'package:image_picker/image_picker.dart';
  uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70, maxHeight: 512, maxWidth: 512);
      if(image != null){
        imageUploading.value = true;
        //Upload image
        final imageUrl = await userRepository.uploadImage('Users/Images/Profile/', image);

        //Update User Image Record
        Map<String, dynamic> json = {'ProfilePicture' : imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        //Show success message
        TLoaders.successSnackBar(title: 'Successfully', message: 'Your Profile Image has been updated.');
      }
    }
    catch (e){
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: 'Something went wrong : $e');
    }
    finally {
      imageUploading.value = false;
    }
  }
}