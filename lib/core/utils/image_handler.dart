import 'package:file_picker/file_picker.dart';

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
}
