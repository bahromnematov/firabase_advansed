import 'package:firabase_advansed/model/post_model.dart';
import 'package:firabase_advansed/pages/home_page.dart';
import 'package:firabase_advansed/servise/rtdb_servise.dart';
import 'package:flutter/material.dart';

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

  _createPost(){
    String firstName=firstNameController.text.toString();
    String lastName=lastNameController.text.toString();
    String content=contentController.text.toString();
    String date=dateController.text.toString();
    if(firstName.isEmpty||lastName.isEmpty||content.isEmpty||date.isEmpty)return;

    _apiCreatePost(firstName,lastName,content,date);

  }

  _apiCreatePost(String firstName,String lastName,String content,String date){
    setState(() {
      isLoading=true;
    });
    var post=Post(first_name: firstName,last_name: lastName,content: content,date: date);
    RTDBServise.addPost(post).then((value) => {
      _resAddPost(),
    });

  }

  _resAddPost(){
    setState(() {
      isLoading=false;
    });
    Navigator.of(context).pop({'data':'done'});
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
