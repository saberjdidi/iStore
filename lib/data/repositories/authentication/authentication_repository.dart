import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_store/common/widgets/navigation_menu_widget.dart';
import 'package:i_store/data/repositories/user/user_repository.dart';
import 'package:i_store/features/authentication/screens/login_screen.dart';
import 'package:i_store/features/authentication/screens/onboarding_screen.dart';
import 'package:i_store/features/authentication/screens/verify_email_screen.dart';
import 'package:i_store/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:i_store/utils/exceptions/firebase_exceptions.dart';
import 'package:i_store/utils/exceptions/format_exceptions.dart';
import 'package:i_store/utils/exceptions/platform_exceptions.dart';
import 'package:i_store/utils/local_storage/storage_utility.dart';
import 'package:i_store/utils/pref_utils.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

   ///Variables
   final deviceStorage = GetStorage();
   final _auth = FirebaseAuth.instance;

   ///Get authenticated user data
  User? get authUser => _auth.currentUser;

  ///Called from main.dart on app launch
  @override
  void onReady() {
    //Remove the native splash screen
    FlutterNativeSplash.remove();
    //Redirect to the appropriate screen
    screenRedirect();
  }

  ///Function to show relevant screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if(user != null){
      if(user.emailVerified){

        //Initialize user specific storage
        await TLocalStorage.init(user.uid);

        Get.offAll(() => const NavigationMenuWidget());
      }
      else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      }
    }
    else {
      ///First Method using GetStorage()
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen());
      ///Second Method using SharedPreference
     /* await PrefUtils.getIsBoarding() == "true"
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnBoardingScreen()); */
    }

  }

  /* --------------------------------  Email & Password Sign-in   --------------------------------------- */
 ///[EmailAuthentication] - SignIn
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }
    on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

 ///[EmailAuthentication] - REGISTER
 Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
   try {
     return await _auth.createUserWithEmailAndPassword(email: email, password: password);
   }
   on FirebaseAuthException catch (e){
     throw TFirebaseAuthException(e.code).message;
   }
   on FirebaseException catch (e){
     throw TFirebaseException(e.code).message;
   }
   on FormatException catch (_){
     throw const TFormatException();
   }
   on PlatformException catch (e){
     throw TPlatformException(e.code).message;
   }
   catch (e) {
     throw 'Something went wrong. Please try again';
   }
 }

  ///[EmailAuthentication] - MAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    }
    on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[EmailAuthentication] - FORGET PASSWORD
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    }
    on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///[ReAuthenticate] - RE AUTHENTICATE USER
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      //Create credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      //ReAuthenticate
       await _auth.currentUser!.reauthenticateWithCredential(credential);
    }
    on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  /* --------------------------------  Federated identity & Social Sign-in   --------------------------------------- */
  ///[GoogleAuthentication] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async {
    try {
      //Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      //obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      //Create a new credential
      final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      //Once Signed in, return the user credentials
      return await _auth.signInWithCredential(credentials);
    }
    on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      if(kDebugMode) print('Something went wrong : $e');
      return null;
      //throw 'Something went wrong. Please try again';
    }
  }

  ///[logoutUser] - Valid for any authentication
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    }
    on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  ///Delete User - Remove user Auth and FireStore Account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    }
    on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    }
    on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    }
    on FormatException catch (_){
      throw const TFormatException();
    }
    on PlatformException catch (e){
      throw TPlatformException(e.code).message;
    }
    catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}