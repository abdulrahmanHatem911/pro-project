import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackButton extends StatelessWidget {
  // final String userEmail = 'zeyadshaban886@gmail.com';

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _sendEmail('zeyadshaban886@gmail.com');
      },
      child: Text('Send Feedback'),
    );
  }

  _sendEmail(String userEmail) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: '',
      queryParameters: {
        'to': userEmail,
        'subject': 'Feedback',
        'body': 'Type your feedback here',
      },
    );
    await launchUrl(emailLaunchUri);
  }
}
