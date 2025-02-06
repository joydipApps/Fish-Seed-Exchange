import 'package:flutter/material.dart';

import '../appbar/common_app_bar.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        'Terms & Conditions',
        isIconBack: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms & Conditions',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Welcome to the Iotivity! Please read these terms and conditions carefully before using our services.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              Text(
                'Acceptance of Terms',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'By downloading, installing, or using the Fishing App, you agree to comply with and be bound by these terms and conditions. If you do not agree with these terms, please do not use the app.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20.0),
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Your use of the Fishing App is also governed by our Privacy Policy. Please review the Privacy Policy to understand how we collect, use, and protect your data.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              // Include bullet points for Privacy Policy content here

              SizedBox(height: 20.0),
              Text(
                'User Registration',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'You may be required to register an account to access certain features of the app. You must provide accurate and complete information during the registration process. You are responsible for maintaining the confidentiality of your account credentials.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              // Include bullet points for User Registration content here

              SizedBox(height: 20.0),
              Text(
                'Updates and Changes',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'We reserve the right to update, modify, or change the app\'s features, content, or functionality at any time without notice. You are responsible for keeping the app up to date.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              // - copyright
              SizedBox(height: 20.0),
              Text(
                'Copyright',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "The content and materials provided through the Fish Books App, including but not limited to text, images, videos, and any other intellectual property, are protected by copyright laws. All rights to these materials are owned or licensed by Fish Books. However, it's important to note that the copyright of the content, books, articles, and any other works published on the Fish Books App belongs to the respective author(s). Fish Books facilitates the digital publication and distribution of the author's work and does not claim ownership of the author's content.\n\nYou agree not to reproduce, distribute, modify, or create derivative works from any content on the App without the prior written consent of both Fish Books and the respective author. To copy or reproduce any of the published material from the author, you must obtain written permission from the author. The knowledge and views presented in the content are those of the author.",
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),

              // copyright end
              SizedBox(height: 20.0),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'If you have any questions or concerns regarding these terms and conditions, please contact us at admin@iotivity.in.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20.0),
              Text(
                'By using the Fish Book App, you acknowledge that you have read, understood, and agree to be bound by these terms and conditions. These terms may be updated from time to time, so please check for updates regularly.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20.0),
              Text(
                'Thank you for using the Fish Books. We commit you to cast knowledge into your hands, one click at a time.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
