import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../model/post_model.dart';

class RTDBServise {
  static final _database = FirebaseDatabase.instance.ref();

  static Future<Stream<DatabaseEvent>> addPost(Post post) async {
    _database.child("post").push().set(post.toJson());
    return _database.onChildAdded;
  }

  static Future<List<Post>> getPost() async{
    List<Post> items=[];
    Query _query=_database.ref.child("posts");
    DatabaseEvent event=await _query.once();
    var snapshot=event.snapshot;

    for(var child in snapshot.children){
      var jsonPost =jsonEncode(child.value);
      Map<String,dynamic> map =jsonDecode(jsonPost);
      var post=Post(first_name: map['first_name'],last_name: map['last_name'],content: map['content'],date: map['data']);
      items.add(post);
    }

    return items;
  }
}
