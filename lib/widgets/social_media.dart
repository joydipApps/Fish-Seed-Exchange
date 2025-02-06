import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/constants.dart';
import '../utils/truncate_paragraph.dart';

void shareContent(
    BuildContext context, String kShareBody, String kShareSubject) {
  String kTrunkBody = truncateParagraph(kShareBody);
  String completeShareBody = kTrunkBody + kDownloadFrom;
  Share.share(
    completeShareBody,
    subject: kShareSubject,
  );
}

IconButton buildShareIconButton(
  BuildContext context, {
  required Color kColor,
  required String kShareBody,
  required String kShareSubject,
}) {
  return IconButton(
    icon: Icon(
      Icons.share,
      color: kColor,
    ),
    iconSize: 20,
    onPressed: () {
      shareContent(context, kShareBody, kShareSubject);
    },
  );
}
