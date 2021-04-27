import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String photoURL;

  UserAvatar(this.photoURL);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(50),
        // color: Colors.orangeAccent,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
                backgroundImage: photoURL != null ?
                NetworkImage(photoURL)
                    : AssetImage('images/avatar.png')
            )
          ),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: Container(
          //     height: 12,
          //     width: 12,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.green,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}