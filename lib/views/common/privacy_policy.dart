import 'package:flutter/material.dart';

import '../appbar/common_app_bar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        'Privacy Policy',
        isIconBack: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Thank you for choosing iotivity.in or our associated websites or published mobile apps. We are dedicated to safeguarding the confidentiality of your personal data and maintaining your privacy. When you use our application or website, we will collect, use, disclose, and protect your data as described in this Privacy Policy.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              Text(
                'Information We Collect',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'When you register or use our services, we may gather personal information about you, including your name, email address, and other pertinent information. We might also gather non-personal data, such as analytics information, device information, and usage trends.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              Text(
                'How We Use Your Information',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'We utilize the data we collect to connect with you, offer and enhance our services, and tailor your experience. For analytical purposes, we might also use anonymised and aggregated data.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              Text(
                'Data Security',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'To prevent unauthorized access, disclosure, alteration, and destruction of your information, we employ industry-standard security measures.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              Text(
                'Third-Party Services',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'We might make use of outside services for advertising, analytics, or other objectives. Information may be gathered and used by these services in accordance with their own privacy rules.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              Text(
                'Your Choices',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'You have the right to access, correct, or delete your personal information. You can manage your preferences and opt-out of certain communications.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              Text(
                'Updates to the Privacy Policy',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'We may update this Privacy Policy to reflect changes in our practices. Please review the policy periodically for any updates.You acknowledge and agree to the terms of this Privacy Policy by using iotivity.in, or any other website hosted or mobile apps published by us. For any inquiries or worries, kindly get in touch with us at admin@iotivity.in',
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
