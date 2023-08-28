import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_mazoon/core/models/user_model.dart';
import 'package:new_mazoon/core/preferences/preferences.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/app_strings.dart';
import '../cubit/state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.api) : super(InitProfileState());

  ServiceApi api;

  XFile? imageFile;
  String imagePath = '';
  static bool mode = false;
  static Future<bool> getSavedMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(AppStrings.mode) ?? false;
  }

  static Future<void> savedMode() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(AppStrings.mode, mode);
  }

  ///
  changeMode(value) async {
    emit(IChangeModeProfileState());
    mode = value;
    await savedMode();
    await getSavedMode();
    emit(ChangeModeProfileState());
  }

  ///
  UserModel? userModel;

  getProfile() async {
    emit(LoadingGetProfileState());
    final response = await api.getProfile();
    response.fold((l) {
      emit(ErrorGetProfileState());
    }, (r) {
      userModel = r;
      Preferences.instance.setUser(r);
      Preferences.instance.getUserModel();
      emit(LoadedGetProfileState());
    });
  }

  ///
  ///

  pickImage({required String type}) async {
    imageFile = await ImagePicker().pickImage(
      source: type == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: imageFile!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9
      ],
      cropStyle: CropStyle.rectangle,
      compressFormat: ImageCompressFormat.png,
      compressQuality: 90,
    );
    imagePath = croppedFile!.path;

    print('download');
    updateProfile(imagePath);
/////edit and get Profile
    // if (type1 == "1") {
    //   addcommment("file", imagePath, '');
    // } else {
    //   addreplay("file", imagePath, '');
    // }
  }

  updateProfile(String imagePath) async {
    final response = await api.updateProfile(imagePath);
    response.fold((l) => emit(ErrorUpdateProfileState()), (r) {
      userModel = r;
      Preferences.instance.setUser(r);
      Preferences.instance.getUserModel();
      // getProfile();

      emit(LoadedUpdateProfileState());
    });
  }

  ///get
}
