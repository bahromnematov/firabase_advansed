import 'package:firabase_advansed/pages/create_page.dart';
import 'package:firabase_advansed/servise/auth_servise.dart';
import 'package:firabase_advansed/servise/rtdb_servise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  static const route = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  bool isLoading = false;
  List<Post> items = [];

  Future _callCreatePage() async {
    Map results = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return CreatePage();
    }));
    if (results != null && results.containsKey("data")) {
      print(results['data']);
      _apiPostList();
    }
  }

  _apiPostList() async {
print("sad");
    setState(() {
      isLoading = true;
    });
    var list = await RTDBServise.getPost();
    setState(() {
      items = list;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _apiPostList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("All Posts"),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [
          IconButton(
              onPressed: () {
                AuthServise.signOutUser(context);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Stack(
        children: [
       FutureBuilder(builder: (_,snapshot) {
         return  ListView.builder(
             itemCount: items.length,
             itemBuilder: (ctx, index) {
               return ListTile(
                 title: itemofPost(items[index]),
               );
             });
       }


       )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          _callCreatePage();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget itemofPost(Post post) {
    return Slidable(
      startActionPane: ActionPane(
        extentRatio: 0.35,
        motion: ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {},
        ),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {},
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: "Update",
          )
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {},
            flex: 3,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Delete",
          )
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      post.first_name!,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      post.last_name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 24),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  post.date.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  post.content.toString(),
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
