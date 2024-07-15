import 'package:flutter/material.dart';
import 'package:SecondSpin/utils/color_constants.dart';

class MessageListPage extends StatelessWidget {
  final List<Message> messages = [
    Message(
        userImage: 'assets/avatar.jpg',
        userName: 'Lihua',
        messageContent: 'hello!'),
    Message(
        userImage: 'assets/avatar.jpg',
        userName: 'Jack',
        messageContent:
            'Can the price of this item be a bit cheaper? I really like it.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcontentColor,
      appBar: AppBar(
        backgroundColor: kcontentColor,
        centerTitle: true,
        title: const Text(
          "Messages",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leadingWidth: 60,
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return MessageListItem(message: messages[index]);
        },
      ),
    );
  }
}

class Message {
  final String userImage;
  final String userName;
  final String messageContent;

  Message(
      {required this.userImage,
      required this.userName,
      required this.messageContent});
}

class MessageListItem extends StatelessWidget {
  final Message message;

  MessageListItem({required this.message});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(message.userImage),
      ),
      title: Text(message.userName),
      subtitle: Text(message.messageContent),
    );
  }
}
