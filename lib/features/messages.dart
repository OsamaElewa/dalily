import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';

class MessagesScreen extends StatefulWidget {
  MessagesScreen({super.key, required this.messages,});
  final List messages;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: widget.messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            20,
                          ),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 0 : 20),
                          topLeft: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 20 : 0),
                        ),
                        color: widget.messages[index]['isUserMessage']
                            ? Colors.grey.shade800
                            : Colors.grey.shade900.withOpacity(0.8),
                      gradient: LinearGradient(
                      colors: widget.messages[index]['isUserMessage']? AppColors.greyGradient : AppColors.blueGradient,
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                    ),
                    constraints: BoxConstraints(maxWidth: w * 2 / 3),
                    child:
                    Text(widget.messages[index]['message'].text.text[0],style: TextStyle(color: Colors.white),),),
              ],
            ),
          );
        },
        separatorBuilder: (_, i) => Padding(padding: EdgeInsets.only(top: 10)),
        itemCount: widget.messages.length);
  }
}
