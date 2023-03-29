import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StoreServise {
  static final _storage = FirebaseStorage.instance.ref();
  static const folder = "post_images";

  static Future<String> uploadImage(File _image) async {
    String img_name = "image_" + DateTime.now().toString();
    var firabaseStorageRef = _storage.child(folder).child(img_name);
    var uploadTask = firabaseStorageRef.putFile(_image);
    final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String downloadUrl = await firabaseStorageRef.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }
}
