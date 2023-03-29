import 'dart:io';

import 'package:firabase_advansed/model/post_model.dart';
import 'package:firabase_advansed/pages/home_page.dart';
import 'package:firabase_advansed/servise/rtdb_servise.dart';
import 'package:firabase_advansed/servise/storage_servise.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePage extends StatefulWidget {
  static const route = "create_page";

  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var isLoading = false;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var contentController = TextEditingController();
  var dateController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  _createPost() {
    String firstName = firstNameController.text.toString();
    String lastName = lastNameController.text.toString();
    String content = contentController.text.toString();
    String date = dateController.text.toString();
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        content.isEmpty ||
        date.isEmpty) return;

    if (_image != null) print("fsf");
    _apiUploadImage(firstName, lastName, content, date);

    // _apiCreatePost(firstName, lastName, content, date,);
  }

  _apiUploadImage(
      String firstName, String lastName, String content, String date) {
    setState(() {
      isLoading = true;
    });
    StoreServise.uploadImage(_image!).then((img_url) => {
          _apiCreatePost(firstName, lastName, content, date, img_url),
        });
  }

  _apiCreatePost(String firstName, String lastName, String content, String date,
      String img_url) {
    setState(() {
      isLoading = true;
    });
    var post = Post(
        first_name: firstName,
        last_name: lastName,
        content: content,
        img_url: img_url,
        date: date);
    RTDBServise.addPost(post).then((value) => {
          _resAddPost(),
        });
  }

  _resAddPost() {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({'data': 'done'});
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("Eror");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text("Create a Post"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _getImage,
                  child: Container(
                    height: 110,
                    width: 110,
                    child: _image != null
                        ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          )
                        : Image.asset("assets/images/ic_camera1.png"),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: firstNameController,
                  decoration: InputDecoration(hintText: "First Name"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: lastNameController,
                  decoration: InputDecoration(
                    hintText: "Last Name",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                    hintText: "Content",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    hintText: "Date",
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  padding: EdgeInsets.all(16),
                  color: Colors.deepOrangeAccent,
                  onPressed: () {
                    _createPost();
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
