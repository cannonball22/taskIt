import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImagingService {
  //
  static final ImagePicker _service = ImagePicker();

  //

  //
  static Future<Uint8List?> capture(
      CameraDevice cameraDevice, int imageQuality) async {
    XFile? image = await _service.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: cameraDevice,
        imageQuality: imageQuality);
    if (image != null) {
      return await image.readAsBytes();
    }
    return null;
  }

  static Future<XFile?> captureSingleImages() async {
    XFile? image = await _service.pickMedia();

    if (image != null) {
      return image;
    }
    return null;
  }

  static Future<List<XFile>?> captureMultiImages() async {
    List<XFile> images = await _service.pickMultiImage();

    if (images != null) {
      return images;
    }
    return null;
  }
}
