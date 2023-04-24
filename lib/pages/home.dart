import 'package:firsty_app/constants/colors.dart';
import 'package:firsty_app/models/post.dart';
import 'package:firsty_app/widgets/post_item.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final postList = Post.PostList();
  final _postController = TextEditingController();
  List<Post> _foundPost = [];

  @override
  void initState() {
    _foundPost = postList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          // -------------------TEXTO DE POST-----------
                          margin: EdgeInsets.only(top: 27, bottom: 20),
                          child: Text(
                            "Posts",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        // -------------------POSTS-------------------
                        for (Post posts in _foundPost.reversed)
                          PostItem(
                            post: posts,
                            onPostChange: _handleToDoChange,
                            deletePostItem: _deletePostItem,
                          ),
                      ],
                    ),
                  )
                ],
              )),
          //______________________________CREATE POST INPUT______________
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0),
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _postController,
                    decoration: InputDecoration(
                        hintText: 'Add a new post', border: InputBorder.none),
                  ),
                )),
                Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20),
                  child: ElevatedButton(
                    child: Text(
                      '+',
                      style: TextStyle(fontSize: 40),
                    ),
                    onPressed: () {
                      _addPostItem(_postController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: tdBlue,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

//____________________________HandleToChange
  void _handleToDoChange(Post post) {
    setState(() {
      post.isDone = !post.isDone;
    });
  }

//______________________________Delete post
  void _deletePostItem(String id) {
    setState(() {
      postList.removeWhere((item) => item.id == id);
    });
  }

//______________________________Create post
  void _addPostItem(String description) {
    setState(() {
      postList.add(Post(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          description: description));
    });
    _postController.clear();
  }

//____________________________SEARCH INPUT__________________________________
  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }

//________________________FUND POST_________________
  void _runFilter(String enteredKeyword) {
    List<Post> results = [];
    if (enteredKeyword.isEmpty) {
      results = postList;
    } else {
      results = postList
          .where((item) => item.description!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundPost = results;
    });
  }

// -----------------------------HEAD-------------------------------------------
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0, // Elimina la sombra del Header
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            child:
                Text("Fisrty", style: TextStyle(color: tdBlack, fontSize: 27)),
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/bob.jpg')),
          )
        ],
      ),
    );
  }
}
