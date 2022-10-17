import 'package:chatter/widget/chat/new_message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatter/widget/chat/messages.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
        actions: [
          DropdownButton(
            icon: const Icon(
                Icons.more_vert,
              color: Colors.white,
            ),
            items: [
              DropdownMenuItem(
                value: 'Logout',
                child: Row(
                  children: const [
                    Icon(
                        Icons.exit_to_app,
                      color: Colors.black,
                    ),
                    Text('   Logout'),
                  ],
                ),
              ),
            ],
            onChanged: (value){
              if(value == 'Logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Column(
        children:  [
          const Messages(),
          NewMessage(),
        ],
      )
    );
  }
}
