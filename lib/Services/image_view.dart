import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewImage {
  static void showCustomDialog(BuildContext context, String url) {
    showGeneralDialog(
        context: context,
        pageBuilder: (_, __, ___) {
          return StatefulBuilder(builder: (context, setState) {
            return Scaffold(
                body: Container(
              child: PhotoView(
                imageProvider: CachedNetworkImageProvider(
                  url,
                ),
              ),
            ));
          });
        });
  }
}
