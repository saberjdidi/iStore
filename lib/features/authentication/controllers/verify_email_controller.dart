import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/success_screen.dart';
import 'package:i_store/data/repositories/authentication/authentication_repository.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/text_strings.dart';
import 'package:i_store/utils/popups/loaders.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  ///Send Email whenever verify screen appears & set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();

    super.onInit();
  }

  ///Send Email verification link
   sendEmailVerification() async {
    try {
       await AuthenticationRepository.instance.sendEmailVerification();

       //Show success message
        TLoaders.successSnackBar(title: 'Email Sent', message: 'Please Check your inbox and verify your email.');
    }
    catch (e){
      //Show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
   }

   ///Timer to automatically redirect on Email Verification
   setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user?.emailVerified ?? false){
        timer.cancel();
        Get.off(() => SuccessScreen(
            image: TImages.successfullyRegisterAnimation,
            title: TTexts.yourAccountCreatedTitle,
            subTitle: TTexts.yourAccountCreatedSubTitle,
            onPressed: () => AuthenticationRepository.instance.screenRedirect()
        )
        );
      }
    });
   }

   ///Manually Check if email verified
   checkEmailVerificationStatus() async {
     final currentUser = FirebaseAuth.instance.currentUser;
     if(currentUser != null && currentUser.emailVerified){
       Get.off(() => SuccessScreen(
           image: TImages.successfullyRegisterAnimation,
           title: TTexts.yourAccountCreatedTitle,
           subTitle: TTexts.yourAccountCreatedSubTitle,
           onPressed: () => AuthenticationRepository.instance.screenRedirect()
       )
       );
     }
   }
}