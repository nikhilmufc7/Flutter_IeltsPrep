import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {Key key,
      this.message,
      this.isMe,
      this.firstName,
      this.imageUrl,
      this.time})
      : super(key: key);

  final String message;
  final bool isMe;
  final String firstName;
  final String imageUrl;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    DateTime format = time.toLocal();

    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12),
                            bottomLeft: !isMe
                                ? Radius.circular(0)
                                : Radius.circular(12),
                            bottomRight: isMe
                                ? Radius.circular(0)
                                : Radius.circular(12)),
                        color: isMe
                            ? Color.fromRGBO(0, 102, 255, 0.7)
                            : Color.fromRGBO(153, 194, 255, .4)),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    margin: EdgeInsets.only(
                        top: 16, bottom: 0, left: 50, right: 50),
                    child: Column(
                      crossAxisAlignment: isMe
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          firstName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isMe
                                  ? Colors.white
                                  : Theme.of(context).accentColor,
                              fontSize: 13,
                              fontFamily: 'Montserrat'),
                        ),
                        Text(
                          message,
                          textAlign: isMe ? TextAlign.end : TextAlign.start,
                          style: TextStyle(
                            color: isMe
                                ? Colors.white
                                : Theme.of(context).accentColor,
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: isMe ? 0 : 50,
                      left: isMe ? 50 : 0,
                    ),
                    child: Text(
                      DateFormat('E').add_jm().format(format),
                      textAlign: isMe ? TextAlign.start : TextAlign.end,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Montserrat',
                          color: Theme.of(context).accentColor),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 20,
          left: isMe ? null : 5,
          right: isMe ? 5 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
        )
      ],
      overflow: Overflow.visible,
    );
  }
}
