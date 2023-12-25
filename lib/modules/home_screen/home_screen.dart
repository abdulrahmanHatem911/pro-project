import 'package:flutter/material.dart';

import 'feedback.dart';
import 'image_row.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              // color: Colors.green,
              child: const Image(
                image: AssetImage('assets/images/image6.png'),
                width: double.infinity,
                height: 300.0,
              ),
            ),
            /*  Expanded(
                  child: Row(
                    children: [
                      ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          
                          return Image.asset(imagePaths[index]);
                        },

                      ),
                    ],
                  ),
                )*/

            ImageRow(),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                'copy right Dr Helal Ahamed @ 2019/2023',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(child: FeedbackButton()),
            const SizedBox(
              height: 20,
            ),
          ]),
    );
  }
}
