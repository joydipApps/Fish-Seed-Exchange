import 'package:flutter/material.dart';

class SnackBarHelper {
  void showSnackDialog({
    required BuildContext context,
    required bool showMe,
    required int msgNo,
    required String message,
  }) {
    final currentContext = context;
    IconData iconData = Icons.check_circle;
    Color iconColor = Colors.white;
    String header = 'Success';

    if (msgNo == 1) {
      header = 'Success';
      iconData = Icons.check_circle;
      iconColor = Colors.green;
    } else if (msgNo == 2) {
      header = 'Failure';
      iconData = Icons.cancel;
      iconColor = Colors.red;
    } else if (msgNo == 3) {
      header = 'Warning';
      iconData = Icons.warning;
      iconColor = Colors.orange;
    } else if (msgNo == 4) {
      header = 'Data Not Found';
      iconData = Icons.warning;
      iconColor = Colors.purple;
    } else if (msgNo == 5) {
      header = 'Oops - Error';
      iconData = Icons.error;
      iconColor = Colors.red;
    } else if (msgNo == 6) {
      header = 'Network Error';
      iconData = Icons.error;
      iconColor = Colors.red;
    } else {
      header = 'Information';
      iconData = Icons.info;
      iconColor = Colors.grey;
    }

    ScaffoldMessenger.of(currentContext).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(1),
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Icon(
                iconData,
                color: iconColor,
                size: 40,
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
                          fontSize: 18,
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
                          fontSize: 15,
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
        backgroundColor: Colors.yellow.shade100,
        behavior: SnackBarBehavior.floating,
        elevation: 3,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.red.shade100, width: .5),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
