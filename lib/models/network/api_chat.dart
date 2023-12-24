import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class ChatCup {
  static const url ='https://api.openai.com/v1/chat/completions';
  static Future<dynamic> postRequset ({required String msg})async{
      try{
        final result = await post(
          Uri.parse(url),
          headers:{
          "Content-Type" : "application/json",
          "Authorization":"Bearer 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"
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [{"role": "user", "content": msg}],
            "temperature": 0.7
          })

        );
        if (result.statusCode==200)
          {
            print(result.body);
            final data =jsonDecode(result.body);
            return data ['choices'][0]['message']['content'];
          }
        return null;

      }on HttpException catch(e){
        print(e.message);
        return null;
      }

    }
}
