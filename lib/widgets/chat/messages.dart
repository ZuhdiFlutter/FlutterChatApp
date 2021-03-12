import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        final chatDocs = snap.data.documents;
        return FutureBuilder(
            future: FirebaseAuth.instance.currentUser(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                reverse: true,
                itemBuilder: (context, ind) => MessageBubble(
                  chatDocs[ind]['text'],
                  chatDocs[ind]['userId'] == snap.data.uid,
                  chatDocs[ind]['username'],
                  chatDocs[ind]['userImage'],
                  msgKey: ValueKey(chatDocs[ind].documentID),
                ),
                itemCount: chatDocs.length,
              );
            });
      },
    );
  }
}
