// This screen is used to check whether following group is present or not.
// If present then transfer it to desired screen or show error message
// check of any UPDATES available.
// StatusHome -> Sticker -> imageGrid

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wasticker/stickers/stickerGrid.dart';

import '../permisson/storagePermissionDenied.dart';

class Sticker extends StatefulWidget {
  final String _stickerDirectory;
  final Function pageNumberSelector;
  final List stickerReferenceList;
  const Sticker(this.pageNumberSelector, this._stickerDirectory,
      this.stickerReferenceList,
      {super.key});

  @override
  State<Sticker> createState() => _StickerState();
}

class _StickerState extends State<Sticker> {
  Future<int> checkStoragepermission() async {
    debugPrint(
        '.....................................................${widget._stickerDirectory}');
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request().then((value) async {
        if (await Permission.storage.status.isGranted) {
          setState(() {});
        }
      });
    }
    // To check whether directory exist or not

    // var dirStatus = await Directory(widget._statusDirectory).exists();
    // debugPrint(dirStatus);
    if (status.isGranted) {
      debugPrint(widget._stickerDirectory);
      if (!(await Directory(widget._stickerDirectory).exists())) {
        await Directory(widget._stickerDirectory).create(recursive: true);
      }
      return 1;
    } else {
      return 0;
      // return 1;
    }
  }

  InterstitialAd? _interstitialAd;

  @override
  Widget build(BuildContext context) {
    // color: Color.fromRGBO(255, 255, 0, 0.25),
    return FutureBuilder(
      builder: (context, status) {
        if (status.data != null) {
          if (status.data == 1) {
            debugPrint('Sticker is ready ///////////////////////////////////');
            debugPrint('${status.data}');
            return StickerGrid(
                // widget._stickerDirectory,
                // widget.pageNumberSelector,
                '',
                widget.stickerReferenceList,
                _interstitialAd);
          }
          // else if (status.data == 2) {
          //   return Center(
          //     child: Text(
          //       "Account logged out OR doesn't exist.",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         color: Color.fromRGBO(255, 0, 0, 1),
          //         fontFamily: 'Signika',
          //         fontSize: 20,
          //         fontWeight: FontWeight.w600,
          //         letterSpacing: 1,
          //         height: 1.5,
          //       ),
          //     ),
          //   );
          // }
          else {
            return StoragePermissionDenied(
              widget.pageNumberSelector,
            );
          }
        }
        return Container(
            margin: const EdgeInsets.all(40),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
              ],
            ));
      },
      future: checkStoragepermission(),
    );
  }
}
