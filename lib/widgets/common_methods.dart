import 'package:intl/intl.dart';
// import 'package:url_launcher/url_launcher.dart';

String formatBulletinDate(String rawDate) =>
    DateFormat('dd-MMMM-yyyy').format(DateTime.parse(rawDate));

// Your function definition
// void launchURL(String webUrl) {
//   final Uri uri = Uri.parse(webUrl);
//
//   canLaunchUrl(uri).then((canLaunch) {
//     if (canLaunch) {
//       launchUrl(uri);
//     } else {
//       throw 'Could not launch URL';
//     }
//   }).catchError((error) {
//     debugPrint('Error launching URL: $error');
//     // Handle the error as needed
//   });
// }
