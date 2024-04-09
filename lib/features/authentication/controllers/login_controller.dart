import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/data/repositories/authentication/authentication_repository.dart';
import 'package:i_store/features/personalization/controllers/user_controller.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/network_manager.dart';
import 'package:i_store/utils/popups/full_screen_loader.dart';
import 'package:i_store/utils/popups/loaders.dart';
import 'package:i_store/utils/pref_utils.dart';
class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  ///Variables
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(); //Form key for Form Validation
  final hidePassword = true.obs; //Observable for showing/hiding password
  final rememberMe = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();

  final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text = PrefUtils.getEmail() ?? '';
    password.text = PrefUtils.getPassword() ?? '';
    super.onInit();
  }

  /// Email and Password Sign In
  Future<void> emailAndPasswordSignIn() async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.docerAnimation);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      //if(!loginFormKey.currentState!.validate()) return;
       if(!loginFormKey.currentState!.validate()) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Save Data if remember me is selected
      if(rememberMe.value){
        await PrefUtils.setEmail(email.text.trim());
        await PrefUtils.setPassword(password.text.trim());
      }

      //Login user
      final userCredential = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //Remove Loader
       TFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
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

  /// Google Sign In authentication
  Future<void> googleSignIn() async {
    try {
      //Start Loading
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.docerAnimation);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        //Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }


      //Google Authentication
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      //Save User Record
      await userController.saveUserRecord(userCredentials);

      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Redirect
      AuthenticationRepository.instance.screenRedirect();
    }
    catch(e){
      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}