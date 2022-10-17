import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.message, required this.userName, required this.imageUrl, }) : super(key: key);

  final String message;
  final String userName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Column(
                  children: [
                    Text(userName, style: TextStyle(color: Colors.white),),
                    Text(message),

                  ],
                ),
              ),
            ]
        ),
        Positioned(
          left: 110,
          top: -10,
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),

        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
