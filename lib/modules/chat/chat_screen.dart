import 'package:flutter/material.dart';

import '../../models/network/api_chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  final _question = TextEditingController();
  String _answerText = '';
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        title: const Text('chatgpt'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade800,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              children: [
                Text(_answerText,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                        )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blueGrey.shade800,
                  ),
                  child: TextField(
                    controller: _question,
                    decoration: const InputDecoration(
                      hintText: 'ask your quastion!',
                      hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      border: InputBorder.none,
                    ),
                  ),
                )),
                const SizedBox(width: 10),
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _sendRequest,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade900,
                            fixedSize: const Size(50, 50)),
                        child: const Icon(Icons.send))
              ],
            ),
          ),
        ],
      ),
    );
  }

  _sendRequest() async {
    setState(() {
      _loading = true;
    });
    final result = await ChatCup.postRequset(msg: _question.text);
    setState(() {
      _loading = false;
    });
    if (result != null) {
      setState(() {
        _answerText = result;
        _question.clear();
      });
    }
  }
}


//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../models/network/api_chat.dart';
//
// class ChatScreen extends StatefulWidget {
// const ChatScreen({Key? key}) : super(key: key);
//
// @override
// State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
// final _question = TextEditingController();
// List<String> _messages = []; // قائمة الرسائل
// bool _loading = false;
//
// @override
// Widget build(BuildContext context) {
// return Scaffold(
// backgroundColor: Colors.blueGrey.shade900,
// appBar: AppBar(
// title: const Text('chatgpt'),
// centerTitle: true,
// backgroundColor: Colors.blueGrey.shade800,
// ),
// body: Column(
// children: [
// Expanded(
// child: ListView(
// padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
// children: _messages.map((message) {
// return Padding(
// padding: const EdgeInsets.symmetric(vertical: 5.0),
// child: Text(
// message,
// style: Theme.of(context).textTheme.bodyLarge?.copyWith(
// height: 1.5,
// ),
// ),
// );
// }).toList(),
// ),
// ),
// Padding(
// padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
// child: Row(
// children: [
// Expanded(
// child: Container(
// padding: const EdgeInsets.symmetric(horizontal: 15),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(50),
// color: Colors.blueGrey.shade800,
// ),
// child: TextField(
// controller: _question,
// decoration: const InputDecoration(
// hintText: 'ask your question!',
// hintStyle: TextStyle(fontWeight: FontWeight.w300),
// border: InputBorder.none,
// ),
// ),
// ),
// ),
// const SizedBox(width: 10),
// _loading
// ? const CircularProgressIndicator()
//     : ElevatedButton(
// onPressed: _sendRequest,
// style: ElevatedButton.styleFrom(
// backgroundColor: Colors.green.shade900,
// fixedSize: const Size(50, 50),
// ),
// child: const Icon(Icons.send),
// )
// ],
// ),
// ),
// ],
// ),
// );
// }
//
// _sendRequest() async {
// setState(() {
// _loading = true;
// });
//
// final result = await ChatCup.postRequset(msg: _question.text);
//
// setState(() {
// _loading = false;
// });
//
// if (result != null) {
// setState(() {
// _messages.add(result); // إضافة الرد الجديد إلى قائمة الرسائل
// _question.clear();
// });
// }
// }
// }
//
//
