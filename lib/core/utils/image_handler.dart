import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageHandler {
  static Future<String?> pickImage() async {
    String? path;
    var tmp = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    path = tmp?.files.single.path!;
    return path;
  }

 static void selectMultipleImage() async {
    List<File>? listImagePath;
    List<XFile>? images;
    ImagePicker photo = ImagePicker();
    if (images != null) {
      images = await photo.pickMultiImage();
      for (XFile file in images) {
        listImagePath!.add(File(file.path));
      }
    } else {
      Get.snackbar('fail', 'no image selected',
          snackPosition: SnackPosition.TOP);
    }
  }
}
