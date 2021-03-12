import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String msg;
  final bool isMe;
  final Key msgKey;
  final String userName;
  final String userImage;

  MessageBubble(this.msg, this.isMe, this.userName, this.userImage,
      {this.msgKey});
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.blueGrey : Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 140,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Row(
                    children: [
                      if (isMe)
                        CircleAvatar(
                          backgroundImage: NetworkImage(userImage),
                        ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        userName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      if (!isMe)
                        CircleAvatar(
                          backgroundImage: NetworkImage(userImage),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  msg,
                  style: TextStyle(color: Colors.white),
                  textAlign: isMe ? TextAlign.end : TextAlign.start,
                ),
              ],
            ),
          )
        ]);
  }
}
