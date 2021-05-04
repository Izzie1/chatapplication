import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  String text;
  IconData icon;


  InfoCard(String text, IconData icon){
    this.text = text;
    this.icon= icon;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.teal,
          ),
          title: Text(
            text,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}