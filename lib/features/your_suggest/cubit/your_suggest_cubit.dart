import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_mazoon/core/remote/service.dart';
import 'package:new_mazoon/core/utils/dialogs.dart';
import 'package:record/record.dart';
part 'your_suggest_state.dart';

class YourSuggestCubit extends Cubit<YourSuggestState> {
  YourSuggestCubit(this.api) : super(YourSuggestInitial());

  ServiceApi api;

  TextEditingController suggestionController = TextEditingController();

  ///add method
  ///add using just image
  XFile? imageFile;
  String imagePath = '';
  String audioPath = '';
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
    addNewSuggest("file", '', imagePath);
  }

///////////////
  bool isRecording = false;
  final audioRecorder = Record();
  Stream<FileResponse>? fileStream;

  double pos = 50;

  int ishour = 0;
  Future<void> start() async {
    try {
      if (await audioRecorder.hasPermission()) {
        await audioRecorder.start();
        isRecording = await audioRecorder.isRecording();
        pos = 200;
        emit(Loaded2AddNewYourSuggestInitial());
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> stop(int type) async {
    final path = await audioRecorder.stop();
    isRecording = false;
    pos = 50;
    addNewSuggest("audio", path.toString(), '');
  }

///////////////
  void addNewSuggest(
    String type,
    String audio,
    String image,
  ) async {
    emit(LoadingAddNewYourSuggestInitial());
    final response = await api.addNewSuggest(
        type: type,
        suggestion: suggestionController.text,
        audio: audio,
        image: image);

    response.fold((l) => emit(ErrorAddNewYourSuggestInitial()), (r) {
      successGetBar(r.message);
      suggestionController.clear();
      imageFile = null;
      imagePath = '';
      audioPath = '';
      emit(LoadedAddNewYourSuggestInitial());
    });
  }
}
