import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/loaders/animation_loader.dart';
import 'package:i_store/utils/constants/colors.dart';
import 'package:i_store/utils/helpers/helper_functions.dart';

class TFullScreenLoader {

  ///Open loading dialog
  static void openLoadingDialog(String text, String animation){
    showDialog(
        context: Get.overlayContext!, //use Get.overlayContext for overlay dialog
        barrierDismissible: false, //The dialog can't be dismissed by tapping outside it
        builder: (_) => WillPopScope(
            //PopScope( => replace PopScope by WillPopScope
           //canPop : false, //Disable popping with the back button
          onWillPop: () async {
            return false;
          },
          child:Container(
            color: THelperFunctions.isDarkMode(Get.context!) ? TColors.dark : TColors.white,
            width: double.infinity,
            height: double.infinity,
            child:  Column(
              children: [
                const SizedBox(height: 250,), //Adjust spacing as needed
                TAnimationLoaderWidget(text: text, animation: animation)
              ],
            ),
          ),
        )
    );
  }

  ///Stop the currently Open loading dialog
   static stopLoading(){
    Navigator.of(Get.overlayContext!).pop(); //Close the dialog using the Navigator
   }
}