import 'package:chat_app/widgets/chat/new_msg.dart';

import '../widgets/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (ident) {
              if (ident == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       SizedBox(
      //         height: 15,
      //       ),
      //       IconButton(icon: Icon(Icons.logout), onPressed: ,)
      //     ],
      //   ),
      // ),
      // body: StreamBuilder(
      //   stream: Firestore.instance
      //       .collection('chats/k7cyjdc8iieP4kfUp6xG/messages')
      //       .snapshots(),
      //   builder: (context, snap) {
      //     if (snap.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final docs = snap.data.documents;
      //     return ListView.builder(
      //       itemCount: docs.length,
      //       itemBuilder: (ctx, i) => Container(
      //         padding: EdgeInsets.all(8),
      //         child: Text(docs[i]['text']),
      //       ),
      //     );
      //   },
      // ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
