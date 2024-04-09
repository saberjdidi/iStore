import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:i_store/data/repositories/authentication/authentication_repository.dart';
import 'package:i_store/data/repositories/user/user_repository.dart';
import 'package:i_store/features/authentication/screens/verify_email_screen.dart';
import 'package:i_store/features/personalization/models/user_model.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/network_manager.dart';
import 'package:i_store/utils/popups/full_screen_loader.dart';
import 'package:i_store/utils/popups/loaders.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///Variables
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); //Form key for Form Validation
  final hidePassword = true.obs; //Observable for showing/hiding password
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();


  ///Signup
  void signup() async {
    try {
      debugPrint('We are processing your information');
       //Start Loading
      TFullScreenLoader.openLoadingDialog('We are processing your information...', TImages.docerAnimation);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      //if(!signupFormKey.currentState!.validate()) return;
      if(!signupFormKey.currentState!.validate()) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Privacy & Policy Check
      if(!privacyPolicy.value){
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message: 'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.'
        );
        return;
      }

      //Register user in the Firebase authentication & save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      //Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: ''
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Move to verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));

      //Show success message
      TLoaders.successSnackBar(title: 'Succesfully', message: 'Your account has been created! Verify email to continue.');

    }
    catch(e){
      //Remove Loader
      TFullScreenLoader.stopLoading();

     //Show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
   /* finally {
      //Remove Loader
      TFullScreenLoader.stopLoading();
    } */
  }
}