import 'package:flutter/material.dart';
import 'package:right_spot/model/comment.dart';

class CommentRowView extends StatelessWidget {
  final Comment comment;

  CommentRowView({ @required this.comment });

  @override
  Widget build(BuildContext context) {
    if (comment.user.profilImageUrl != null) {
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage(this.comment.user.profilImageUrl),
                  ),
                ),
                SizedBox(width: 10),
                Text("${comment.user.username} :",
                  style: TextStyle(color: Colors.blueAccent),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Text(this.comment.comment
 
                ),
              ),
            )
          ],
        ),
      );
    }
    else {
      return Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: Text("${this.comment.user.username} :",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.blueAccent
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: Text(this.comment.comment
 
                ),
              ),
            )
          ],
        ),
      );
    }
  }
}