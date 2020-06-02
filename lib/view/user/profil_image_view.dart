import 'package:flutter/material.dart';

class ProfileImageView extends StatelessWidget {
  final String imageurl;

  ProfileImageView({ @required this.imageurl });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 90,
      child: CircleAvatar(
        backgroundImage: (this.imageurl != null)
          ? NetworkImage(this.imageurl)
          : Icon(Icons.person),
        backgroundColor: Colors.white,
        radius: 85,
      ),
    );
  }

}