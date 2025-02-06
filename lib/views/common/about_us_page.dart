// about_us_page.dart - checked
import 'package:flutter/material.dart';
import '../appbar/common_app_bar.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: commonAppBar(
        context,
        'About Us',
        isIconBack: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'About Us',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                "Welcome to Fish Seed Exchange, your trusted resource for everything related to fish seed trading in the Indian subcontinent. At Fish Seed Exchange, we are dedicated to supporting Indian fish seed farmers by providing them with the tools and information needed to thrive. With a simple account creation, our app offers to connect buyer sellers. We believe that knowledge is the key to success in this industry. By sharing valuable production information. we empower fish farmers to boost their yields and grow their businesses sustainably. Join our community today to access a wealth of information that will help you navigate the fish seed trade with confidence. Our mission is to see you succeed.",
                style: TextStyle(
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              Text(
                'Fish is a water crop, if you cultivate it, the profit will be double.',
                style: TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              Text(
                'Our methodology to achieve - Fish is a water crop, if you cultivate it, the profit is double.',
                style: TextStyle(
                  fontSize: 16.0,
                  fontStyle: FontStyle.normal,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
              Text(
                'App ownership:  Prayas Fish Production Group, WB, India.\n',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
                textAlign: TextAlign.justify,
              ),
              Text(
                'Development & NGO partner  : Kaarva Foundation, WB, India.\n',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
                textAlign: TextAlign.justify,
              ),
              Text(
                'App developed by : IoTivity Communications Private Limited , Kolkata, India.',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
