import 'package:firsty_app/constants/colors.dart';
import 'package:firsty_app/models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final onPostChange;
  final deletePostItem;

  const PostItem(
      {Key? key,
      required this.post,
      required this.onPostChange,
      required this.deletePostItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () {
            print("Clicked");
            onPostChange(post);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 5), //Posicion del content en el recuadro blanco
          tileColor: Colors.white, // COLOR de recuadro blanco
          // -----------------------------BOTON AZUL CHECK---------------------------
          leading: Icon(
            post.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue,
          ),
          // ---------------------------------TEXTO-----------------------------
          title: Text(
            post.description!,
            style: TextStyle(
                fontSize: 16,
                color: tdBlack,
                decoration: post.isDone ? TextDecoration.lineThrough : null),
          ),
          //-----------------------------BOTON DELETE-----------------------
          trailing: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.symmetric(vertical: 12),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              color: Colors.white,
              iconSize: 18,
              icon: Icon(Icons.delete),
              onPressed: () {
                print("clicked on delete");
                deletePostItem(post.id);
              },
            ),
          ),
        ));
  }
}
