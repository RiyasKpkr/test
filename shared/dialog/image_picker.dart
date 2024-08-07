import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/model/filePickedModel.dart';
import '../../core/constants.dart';
import '../../core/extensions/margin_ext.dart';

import '../../core/screen_utils.dart';
import '../widgets/app_svg.dart';
import '../widgets/app_text.dart';

Future<String?>? showImagePicker() async {
  String? path;
  bool? isCamera;

  await Get.bottomSheet(
    ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12), topLeft: Radius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 200,
        child: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const AppText("Choose From", size: 16, color: primaryClr),
            const Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              InkWell(
                onTap: () {
                  isCamera = false;
                  Screen.closeDialog();
                },
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const AppSvg(assetName: "gallery", height: 48),
                  4.hBox,
                  const AppText("Gallery", family: inter500),
                ]),
              ),
              InkWell(
                onTap: () {
                  isCamera = true;
                  Screen.closeDialog();
                },
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const AppSvg(
                    assetName: "camera",
                    height: 48,
                  ),
                  4.hBox,
                  const AppText("Camera", family: inter500),
                ]),
              ),
            ]),
            const Spacer()
          ]),
        ),
      ),
    ),
    enableDrag: false,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16))),
  );

  if (isCamera == null) return null;

  path = await pickImage(isCamera: isCamera!);

  return path;
}

Future<String?>? pickImage({required bool isCamera}) async {
  String? path;

  XFile? pickedFile =
      await ImageHandler.pickImageFromGallery(isCamera: isCamera);

  if (pickedFile == null) {
    // showToast("Invalid file");
    return path;
  }

  // var file = File(pickedFile!.path);
  // if (file.lengthSync() > 5000000) {
  //       snackBar(context, message: 'Image size exceeds more than 5MB');
  //       return;
  //     }

  debugPrint("FILE LENGTH:${pickedFile.length()}");

  CroppedFile? croppedFile =
      await ImageHandler.cropSelectedImage(pickedFile.path);
  path = croppedFile?.path;
  return path;
}

class ImageHandler {
  /// Open image gallery and pick an image
  static Future<XFile?> pickImageFromGallery({required bool isCamera}) async {
    return await ImagePicker().pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 640);
  }

  /// crop selected Image From Gallery and return a File
  static Future<CroppedFile?> cropSelectedImage(String filePath) async {
    return await ImageCropper().cropImage(
      compressFormat: ImageCompressFormat.png,
      sourcePath: filePath,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: '',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            hideBottomControls: true),
        IOSUiSettings(
          title: '',
          resetButtonHidden: true,
          aspectRatioLockEnabled: true,
        ),
      ],
    );
  }
}

///File picker
Future<List<FilePicked>> pickFile(
    {bool allowMultiple = false, List<String>? allowedExtensions}) async {
  debugPrint("AllowedExtensions:$allowedExtensions");

  FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: allowMultiple,
      type: FileType.custom,
      allowedExtensions: allowedExtensions?.isNotEmpty == true
          ? allowedExtensions
          : [
              'png',
              'jpg',
              'jpeg',
              'csv',
              'txt',
              'pdf',
              'xlx',
              'xls',
              'bmp',
              'gif',
              'svg',
              'webp'
            ]);

  List<FilePicked> files = [];

  if (result != null) {
    for (var file in result.files) {
      final size = file.size ~/ 1000;
      final sizeInMB = size / 1000;
      String sizeText;
      if (sizeInMB >= 1) {
        sizeText = '${sizeInMB.toStringAsFixed(2)} MB';
      } else {
        sizeText = '${size.toStringAsFixed(2)} KB';
      }
      if (sizeInMB > 5) {
        // snackBar(context,
        //     message: "File size maximum of 5MB", type: MessageType.error);
      }
      files.add(FilePicked(
          path: file.path,
          extension: file.extension,
          size: sizeText,
          sizeValid: sizeInMB,
          name: file.name,
          isNetworkImage: false));
    }
  }
  return files;
}
