import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
   NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _editedText = '';

  final _controller = TextEditingController();

   @override
   void dispose() {
     _controller.dispose();
     super.dispose();
   }



   void _sendMessage(BuildContext ctx) async{
     final auth = FirebaseAuth.instance.currentUser;
     final userData = await FirebaseFirestore.instance.collection('users').doc(auth?.uid).get();
     try{
      await FirebaseFirestore.instance.collection('chats').add({
        'text': _editedText,
        'timeCreated': Timestamp.now(),
        'userId': auth?.uid,
        'userName': userData['username'],
        'imageUrl': userData['imageUrl'],
      });
      _controller.clear();
     } catch (e){
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text(e.toString())
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child:
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            label: Text('Send a message'),
          ),
          onChanged: (value){
            _editedText = value;
          },
        ),
        ),
        IconButton(
            icon: const Icon(
              Icons.send
            ),
          onPressed: (){
              if(_editedText.trim().isEmpty){
                return;
              }
              _sendMessage(context);
              _controller.clear();
              _editedText = '';

        },
        ),
      ],
    );
  }
}
