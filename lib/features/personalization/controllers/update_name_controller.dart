import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/data/repositories/user/user_repository.dart';
import 'package:i_store/features/personalization/controllers/user_controller.dart';
import 'package:i_store/features/personalization/screens/profile/profile_screen.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/network_manager.dart';
import 'package:i_store/utils/popups/full_screen_loader.dart';
import 'package:i_store/utils/popups/loaders.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  ///Variables
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  ///Fetch user records
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  Future<void> updateUserName() async {
     try {
       //Start Loading
       TFullScreenLoader.openLoadingDialog('We are updating your information...', TImages.docerAnimation);

       //Check internet connection
       final isConnected = await NetworkManager.instance.isConnected();
       if(!isConnected) {
         //Remove Loader
         TFullScreenLoader.stopLoading();
         return;
       }

       //Form Validation
       if(!updateUserNameFormKey.currentState!.validate()) {
         //Remove Loader
         TFullScreenLoader.stopLoading();
         return;
       }

       //Update first & last Name in Firestore
       Map<String, dynamic> name = {
         'FirstName' : firstName.text.trim(),
         'LastName' : lastName.text.trim()
       };
       await userRepository.updateSingleField(name);

       //Update the Rx User value
       userController.user.value.firstName = firstName.text.trim();
       userController.user.value.lastName = lastName.text.trim();

       //Remove Loader
       TFullScreenLoader.stopLoading();

       //Show success message
       TLoaders.successSnackBar(title: 'Successfully', message: 'Your Name has been updated.');

       //Move to previous screen
       Get.off(() => const ProfileScreen());
     }
     catch (e){
       //Remove Loader
       TFullScreenLoader.stopLoading();

       //Show some generic error to the user
       TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
     }
  }
}