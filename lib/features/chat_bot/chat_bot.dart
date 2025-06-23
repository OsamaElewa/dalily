import 'package:dalily/features/messages.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];
  bool isDialogFlowtterReady = false;

  @override
  void initState() {
    super.initState();
    DialogFlowtter.fromFile(path: 'assets/dialog_flow_auth.json')
        .then((instance) {
      dialogFlowtter = instance;
      setState(() {
        isDialogFlowtterReady = true;
      });
    }).catchError((error) {
      print('Failed to load DialogFlowtter: $error');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بوت دليلي الذكي'),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,size: 25,)),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: MessagesScreen(messages: messages),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: AppColors.blueGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  )),
              child: Row(
                children: [
                  IconButton(onPressed: () {
                    sendMessage(controller.text);
                    controller.clear();
                  }, icon: Icon(Icons.send,color: Colors.white,)),
                  Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          border: InputBorder.none
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  sendMessage(String text) async {
    if (text.isEmpty) {
      print('message is empty');
      return;
    }

    // تأكد أن DialogFlowtter جاهز
    if (!isDialogFlowtterReady) {
      print('DialogFlowtter not initialized yet');
      return;
    }

    setState(() {
      addMessage(Message(text: DialogText(text: [text])), true);
    });

    try {
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
        queryInput: QueryInput(
          text: TextInput(text: text),
        ),
      );

      if (response.message == null) return;

      setState(() {
        addMessage(response.message!);
      });
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  addMessage(Message message,[bool isUserMessage = false]){
    messages.add({'message': message,'isUserMessage' : isUserMessage});
  }
}
