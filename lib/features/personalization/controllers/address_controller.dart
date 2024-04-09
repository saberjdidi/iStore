import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:i_store/common/widgets/texts/section_heading.dart';
import 'package:i_store/data/repositories/address/address_repository.dart';
import 'package:i_store/features/personalization/models/address_model.dart';
import 'package:i_store/features/personalization/screens/address/add_new_address.dart';
import 'package:i_store/features/personalization/screens/address/widgets/single_address.dart';
import 'package:i_store/utils/constants/image_strings.dart';
import 'package:i_store/utils/constants/sizes.dart';
import 'package:i_store/utils/helpers/cloud_helper_functions.dart';
import 'package:i_store/utils/network_manager.dart';
import 'package:i_store/utils/popups/full_screen_loader.dart';
import 'package:i_store/utils/popups/loaders.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = true.obs;

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  ///Fetch addresses of specific user
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere((element) => element.selectedAddress, orElse: () => AddressModel.empty());
      return addresses;
    }
    catch (e) {
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
          title: '',
          onWillPop: () async {return false;},
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: const CircularProgressIndicator()
          //content: const TCircularLoader()
      );
      //Clear the selected field
      if(selectedAddress.value.id.isNotEmpty){
        await addressRepository.updateSelectedField(selectedAddress.value.id, false);
      }

      //Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      //Set the 'selected' field to true for the newly selected address
      await addressRepository.updateSelectedField(selectedAddress.value.id, true);

      Get.back();
    }
    catch (e) {
      TLoaders.errorSnackBar(title: 'Error in selection', message: e.toString());
    }
  }

  ///New Address
  Future addNewAddress() async {
    try {
    //Start Loading
    TFullScreenLoader.openLoadingDialog('Storing Address...', TImages.docerAnimation);

    //Check internet connection
    final isConnected = await NetworkManager.instance.isConnected();
    if(!isConnected) {
      //Remove Loader
      TFullScreenLoader.stopLoading();
      return;
    }

    //Form Validation
    //if(!loginFormKey.currentState!.validate()) return;
    if(!addressFormKey.currentState!.validate()) {
      //Remove Loader
      TFullScreenLoader.stopLoading();
      return;
    }

    //Save Data
    final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true
    );

    final id = await addressRepository.addAddress(address);

    //Update Selected Address status
    address.id = id;
    await selectAddress(address);

    //Remove Loader
    TFullScreenLoader.stopLoading();

    //Show success message
    TLoaders.successSnackBar(title: 'Succesfully', message: 'Your address has been created!');

    //Refresh Data
    refreshData.toggle();

    //Reset Fields
    resetFormFields();

    //Redirect
    Navigator.of(Get.context!).pop();
    }
    catch(e){
      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show some generic error to the user
      TLoaders.errorSnackBar(title: 'Address not found', message: e.toString());
    }
  }

  ///Show addresses ModalBottomSheet at Checkout
  Future<dynamic> selectNewAddressPopup(BuildContext context){
    return showModalBottomSheet(
        context: context,
        builder: (_) => Container(
          padding: const EdgeInsets.all(TSizes.sm),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TSectionHeading(title: 'Select Address', showActionButton: false,),
                FutureBuilder(
                    future: getAllUserAddresses(),
                    builder: (_, snapshot){
                      final response = TCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
                      //Return appropriate widget based on snapshot state
                      if(response != null) return response;

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => SingleAddress(
                            address: snapshot.data![index],
                            onTap: () async {
                              await selectAddress(snapshot.data![index]);
                              Get.back();
                            }
                        ),

                      );
                    }
                ),
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () => Get.to(() => const NewAddressScreen()),
                      child: const Text('Add new address')
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  ///FUnction to reset FormFields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    city.clear();
    state.clear();
    postalCode.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}

