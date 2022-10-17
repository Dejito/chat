import 'package:chatter/widget/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('chats').orderBy(
              'timeCreated', descending: true).snapshots(),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),);
            }
            return Expanded(
              child: ListView.builder(
                  reverse: true,
                  itemCount: chatSnapshot.data?.docs.length,
                  itemBuilder: (ctx, i) {
                    return MessageBubble(
                      imageUrl: chatSnapshot.data?.docs[i]['imageUrl'],
                      userName: chatSnapshot.data?.docs[i]['userName'],
                      message: chatSnapshot.data?.docs[i]['text'],
                      // isMe: chatSnapshot.data?.docs[i]['userId']
                    );
                  }
              ),
            );
          }
    );


  }
}
