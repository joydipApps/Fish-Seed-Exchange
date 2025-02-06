import 'package:flutter/material.dart';

void showSnackDialog(
  BuildContext context,
  int msgNo,
  String message,
) {
  IconData iconData = Icons.check_circle;
  Color iconColor = Colors.transparent;
  String header = 'Success';

  if (msgNo == 1) {
    header = 'Success';
    iconData = Icons.check_circle;
    iconColor = Colors.greenAccent;
  } else if (msgNo == 2) {
    header = 'Setback';
    iconData = Icons.cancel;
    iconColor = Colors.redAccent;
  } else if (msgNo == 3) {
    header = 'Warning';
    iconData = Icons.warning;
    iconColor = Colors.orangeAccent;
  } else if (msgNo == 4) {
    header = 'Data Not Found';
    iconData = Icons.warning;
    iconColor = Colors.grey;
  } else if (msgNo == 5) {
    header = 'Oops - Error';
    iconData = Icons.error;
    iconColor = Colors.redAccent;
  } else if (msgNo == 6) {
    header = 'Network Error';
    iconData = Icons.error;
    iconColor = Colors.redAccent;
  } else {
    header = 'Information';
    iconData = Icons.info;
    iconColor = Colors.blueAccent;
  }
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        padding: const EdgeInsets.all(0), //0
        height: 40, //50,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Row(
          children: [
            Icon(
              iconData,
              color: iconColor,
              size: 30, //40,
            ),
            const SizedBox(width: 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      header,
                      style: const TextStyle(
                        fontSize: 14, //18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  FittedBox(
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 12, //15,
                        fontStyle: FontStyle.italic,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      duration: const Duration(seconds: 2 * 2),
      backgroundColor: Colors.tealAccent.shade100,
      behavior: SnackBarBehavior.floating,
      elevation: 3,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.redAccent, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
