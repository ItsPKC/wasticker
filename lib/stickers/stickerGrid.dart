import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restart_app/restart_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wasticker/wallpaperSetting.dart';
import 'package:whatsapp_stickers_plus/exceptions.dart';
// import 'package:restart_app/restart_app.dart';
// import 'package:whatsapp_stickers_plus/exceptions.dart';
// import 'package:whatsapp_stickers_plus/exceptions.dart';
import 'package:whatsapp_stickers_plus/whatsapp_stickers.dart';
import '../global.dart';

class StickerGrid extends StatefulWidget {
  // final String _path;
  final List stickerReferenceList;
  final String packname;
  final InterstitialAd? _interstitialAd;

  const StickerGrid(
      this.packname, this.stickerReferenceList, this._interstitialAd,
      {super.key});

  @override
  State<StickerGrid> createState() => _StickerGridState();
}

class _StickerGridState extends State<StickerGrid> {
  var isIntAdsShown = false;
  final _scrollController = ScrollController();
  var _details = [];

  // To show the tick if selected
  List<String> isSelected = [];

  // list of selected items
  List<String> selectedItems = [];
  var imageList = [];
  var downloadedImageList = [];
  var downloadPath = '';
  var isAddingSticker = false;
  var waitTime = 10.0;
  var isWaiting = false;

  folderSetUp(thePath) async {
    // final folderName = "WA Assist/Download";
    // final directoryPath = Directory("storage/emulated/0/$folderName");
    final directoryPath = Directory(thePath);
    if (await directoryPath.exists()) {
    } else {
      debugPrint("not exist");
      await directoryPath.create();
    }
    // downloadPath = '/storage/emulated/0/WA Assist/Download';
    downloadPath = thePath;
  }

  copyImage(value) async {
    // Here I have to put file name with extension like xyz.png
    // In our case interpolation out already contains extension
    await File(value).copy('$downloadPath/${File(value).path.split('/').last}');
    debugPrint('${File(value)}');
    debugPrint(File(value).path.split('/').last);

    debugPrint('${File(value)}');
    debugPrint(
        '${await File('$downloadPath/${File(value).path.split('/').last}').exists()}');
    setState(() {});
    // Please add any snack bar to confirm that download is completed
  }

  // Checking Whether image is downloaded or not
  Future<int> checkIfDownloaded(value) async {
    if (await File('$downloadPath/${File(value).path.split('/').last}')
        .exists()) {
      // print('${File(value).path.split('/').last} :: 1');
      return 1;
    } else {
      return 0;
    }
  }

  // Deleting Downloaded Image
  Future<void> deleteIfDownloaded(value) async {
    if (await File('$downloadPath/${File(value).path.split('/').last}')
        .exists()) {
      // print('${File(value).path.split('/').last} :: 1');
      await File('$downloadPath/${File(value).path.split('/').last}').delete();
    } else {}
    setState(() {});
  }

  // refresh Page

  var buildKey = '0';

  Future<void> _refreshNow() async {
    // selectedItems = [];
    // isSelected.fillRange(0, isSelected.length, '');
    // setState(() {});
    // setState with new build key to reload everything;
    setState(() {
      buildKey = (int.parse(buildKey) + 1).toString();
    });
  }

  _onBackPressed() {
    if (selectedItems.isNotEmpty) {
      selectedItems = [];
      isSelected.fillRange(0, isSelected.length, '');
      setState(() {});
      return false;
    } else {
      return true;
    }
  }

  // final firebase_storage.FirebaseStorage _storage =
  //     FireStorageBucket().getInstance;

  // Future<String> _getDownloadLink(getLinkFrom, index) async {
  //   String temp;
  //   // to avoid re-request on setstate
  //   if (imageList[index] == '') {
  //     debugPrint('..........................Getting');
  //     // In the case of firebase
  //     // temp = await _storage.ref(getLinkFrom).getDownloadURL();
  //     // In the case of dpgram.in
  //     temp = 'https://dpgram.in/kingmaker/$getLinkFrom';
  //     imageList[index] = temp;
  //   } else {
  //     return imageList[index];
  //   }
  //   return temp;
  // }

  Future<void> _findPath(String imageUrl, index) async {
    await defaultCacheManager.getSingleFile(imageUrl).then(
      (file) {
        if (isSelected[index] == '') {
          isSelected[index] = file.path;
        } else {
          isSelected[index] = '';
        }
        // To clear last list items and fill the refersh list
        selectedItems.clear();
        for (int i = 0; i < isSelected.length; i++) {
          if (isSelected[i] != '') {
            selectedItems.add(isSelected[i]);
          }
        }
        setState(() {
          isSelected[index] = isSelected[index];
        });
      },
    );
    // debugPrint('For Share = $selectedItems');
    // debugPrint(isSelected);
  }

  scrollToTopLoadAllImage() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  var cwn = chatWallpaper[chatWallpaperNumber];

  manageColor(value) {
    setState(() {
      cwn = chatWallpaper[value];
    });
  }

  var stickerPack = WhatsappStickers(
    identifier: '${DateTime.now().millisecondsSinceEpoch}',
    // identifier: widget.packname.split(' ').join(),
    name: '${DateTime.now().millisecondsSinceEpoch}',
    publisher: 'WASticker',
    trayImageFileName: WhatsappStickerImage.fromAsset('assets/tray_Cuppy.png'),
    publisherWebsite: '',
    privacyPolicyWebsite: '',
    licenseAgreementWebsite: '',
  );

  addToWhatsApp(isForced) async {
    showError(data) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                backgroundColor: const Color.fromRGBO(230, 0, 35, 0.15),
                color: const Color.fromRGBO(0, 128, 105, 1),
                minHeight: 8,
                value: data / imageList.length,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Downloading ...',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(0, 128, 105, 1),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '$data',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(0, 128, 105, 1),
                            ),
                          ),
                          TextSpan(
                            text: '  /  ${imageList.length}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(230, 0, 35, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actionsPadding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Color.fromRGBO(230, 0, 35, 0.2),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                if (waitTime > 0) {
                  isWaiting = true;
                  activateWaiting();
                } else if (isAddingSticker == false) {
                  if (mounted) {
                    setState(() {
                      isAddingSticker = true;
                    });
                    addToWhatsApp(true);
                  }
                }
              },
              child: FittedBox(
                child: Text(
                  'Add Only : $data',
                  style: const TextStyle(
                    letterSpacing: 1,
                    color: Color.fromRGBO(230, 0, 35, 1),
                  ),
                ),
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(230, 0, 35, 1),
                side: const BorderSide(
                  color: Color.fromRGBO(230, 0, 35, 1),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Wait',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // ---------------------------------------------------------------------------

    var applicationDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    var stickersDirectory = Directory(
        '${applicationDocumentsDirectory.path}/stickers/${widget.packname}');
    if (await stickersDirectory.exists()) {
      try {
        await stickersDirectory.delete(recursive: true);
      } catch (e) {
        debugPrint('Error deleting directory: $e');
      }
    }

    await stickersDirectory.create(recursive: true);

    var tempUrl = [];

    // Fetch image from cache directory
    for (var i = 0; i < downloadedImageList.length; i++) {
      await defaultCacheManager.getSingleFile(downloadedImageList[i]).then(
        (file) async {
          // debugPrint('//1/${file.path}');
          File sourceFile = File(file.path);
          try {
            await sourceFile
                .copy('${stickersDirectory.path}/${(i + 1)}.webp')
                .then(
              (File fileF) async {
                // file has been copied
                // debugPrint('//2/${fileF.path}${await File(fileF.path).exists()}');
                tempUrl.add(fileF.path);
              },
            );
          } catch (e) {
            debugPrint('//5/ File copy error\n$e');
            debugPrint('$e');
          }
        },
      ).onError((error, stackTrace) {
        debugPrint('//3/ Path not found\n$error');
      });
    }

    // // Add all sticker in WhatApp image file to push.
    lineUpStickerToPush() {
      for (var i = 0; i < tempUrl.length; i++) {
        debugPrint('//4/${tempUrl[i]}');
        stickerPack
            .addSticker(WhatsappStickerImage.fromFile(tempUrl[i]), ['😂']);
      }
    }

    refresh() {
      Future.delayed(
        const Duration(milliseconds: 100),
        () {
          setState(() {
            isAddingSticker = false;
          });
        },
      );
    }

    stickerAdditionTime(val) async {
      var getVal = prefs.getInt('stickerAdditionTimeController');
      debugPrint('#################################################$getVal');
      await prefs.setInt('stickerAdditionTimeController', val);

      var ggetVal = prefs.getInt('stickerAdditionTimeController');
      debugPrint('#################################################$ggetVal');
    }

    // // Push all sticker
    pushSticker() async {
      try {
        await stickerPack.sendToWhatsApp().then((value) {
          debugPrint('Added Succ');
          stickerAdditionTimeController = DateTime.now().millisecondsSinceEpoch;
          stickerAdditionTime(stickerAdditionTimeController);
          refresh();
          Restart.restartApp();
        });
      } on WhatsappStickersException catch (e) {
        debugPrint(
            '#################################################$e\n\n${imageList.length}\n\n$imageList');
        debugPrint(e.cause);
        Restart.restartApp();
        refresh();
      }
    }

    lineupAndPushSticker() {
      lineUpStickerToPush();
      pushSticker();
    }

    if (imageList.length == tempUrl.length || isForced) {
      lineupAndPushSticker();
    } else {
      refresh();
      debugPrint('#######################################################');
      debugPrint('IL : ${imageList.length} : $imageList');
      debugPrint('TL : ${tempUrl.length} : $tempUrl');
      showError(tempUrl.length);
    }

    // for (var i = 0; i < tempUrl.length; i++) {
    //   debugPrint('//4/${tempUrl[i]}');
    //   stickerPack.addSticker(WhatsappStickerImage.fromFile(tempUrl[i]), ['😂']);
    // }

    // try {
    //   await stickerPack.sendToWhatsApp().then((value) {
    //     Restart.restartApp();
    //     debugPrint('Added Succ');
    //     stickerAdditionTimeController = DateTime.now().millisecondsSinceEpoch;
    //     stickerAdditionTime(stickerAdditionTimeController);
    //     refresh();
    //   });
    // } on WhatsappStickersException catch (e) {
    //   debugPrint(
    //       '#################################################$e\n\n${imageList.length}\n\n$imageList');
    //   debugPrint(e.cause);
    //   // refresh();
    // }
  }

  activateWaiting() async {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          waitTime -= 0.1;
        });
        if (isWaiting && waitTime > 0) {
          activateWaiting();
        } else {
          isWaiting = false;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.packname,
                    style: const TextStyle(
                      color: Color.fromRGBO(0, 128, 105, 1),
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              content: Container(
                height: 120,
                alignment: Alignment.center,
                child: Text(
                  '${widget.stickerReferenceList.length}',
                  style: const TextStyle(
                    fontFamily: 'Signika',
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(0, 128, 105, 1),
                  ),
                ),
              ),
              actionsPadding: const EdgeInsets.fromLTRB(11, 0, 11, 5),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                OutlinedButton(
                  style: const ButtonStyle(
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        color: Color.fromRGBO(255, 0, 0, 1),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color.fromRGBO(255, 0, 0, 1),
                      fontSize: 16,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                OutlinedButton(
                  style: const ButtonStyle(
                    side: MaterialStatePropertyAll(
                      BorderSide(
                        color: Color.fromRGBO(0, 128, 105, 1),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    if (waitTime > 0) {
                      isWaiting = true;
                      activateWaiting();
                    } else if (isAddingSticker == false) {
                      if (mounted) {
                        setState(() {
                          isAddingSticker = true;
                        });
                        addToWhatsApp(false);
                      }
                    }
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      color: Color.fromRGBO(0, 128, 105, 1),
                      fontSize: 16,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // folderSetUp(widget._path);
    _details = widget.stickerReferenceList;
    for (var element in _details) {
      isSelected.add('');
      // imageList.add('');
      imageList.add('https://dpgram.in/kingmaker/$element');
      debugPrint(element);
    }
    scrollToTopLoadAllImage();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //   statusBarColor: Color.fromRGBO(230, 0, 0, 1),
        // ),
        backgroundColor: const Color.fromRGBO(0, 128, 105, 1),
        leading: GestureDetector(
            onTap: () async {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_rounded)),
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => WallPaperSetting(manageColor),
              );
            },
            child: const SizedBox(
              height: 56,
              width: 56,
              child: Icon(
                Icons.color_lens_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ],
        titleSpacing: 0,
        title: Text(
          widget.packname,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontWeight: FontWeight.w500,
            fontSize: 18,
            letterSpacing: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: WillPopScope(
          key: Key(buildKey),
          onWillPop: () async {
            return _onBackPressed();
          },
          child: RefreshIndicator(
            onRefresh: () => _refreshNow(),
            child: Container(
              decoration: BoxDecoration(
                color: cwn['wallpaper'] as Color,
                image: DecorationImage(
                  image: const AssetImage('assets/ChatWallpaper.png'),
                  fit: BoxFit.cover,
                  opacity: cwn['opacity'] as double,
                ),
                // gradient: LinearGradient(
                //   colors: [
                //     Color.fromRGBO(247, 226, 210, 0.6),
                //     Color.fromRGBO(247, 226, 210, 0.6),
                //     // Color.fromRGBO(242, 242, 242, 1),
                //   ],
                //   begin: Alignment.bottomLeft,
                //   end: Alignment.topCenter,
                // ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        (_details.isNotEmpty)
                            ? GridView.builder(
                                controller: _scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: _details.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(15, 20, 15, 80),
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(3),
                                      ),
                                    ),

                                    // index is item - 1
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(3),
                                      child: Stack(
                                        children: [
                                          GestureDetector(
                                            child: Container(
                                              color: Colors.transparent,
                                              alignment: Alignment.topCenter,
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://dpgram.in/kingmaker/${_details[index]}',
                                                imageBuilder:
                                                    (context, imageProvider) {
                                                  if (!downloadedImageList.contains(
                                                      'https://dpgram.in/kingmaker/${_details[index]}')) {
                                                    downloadedImageList.add(
                                                        'https://dpgram.in/kingmaker/${_details[index]}');
                                                  }
                                                  return Container(
                                                    margin:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 1),
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        GestureDetector(
                                                  onTap: () {
                                                    _refreshNow();
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    color: const Color.fromRGBO(
                                                        0, 0, 0, 0.05),
                                                    child: const Icon(
                                                      Icons.download_rounded,
                                                      color: Color.fromRGBO(
                                                          0, 128, 105, 0.5),
                                                      size: 32,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // child: FutureBuilder(
                                              //   builder: (context, snapshot) {
                                              //     // .......................
                                              //     debugPrint(
                                              //         '//-----------------------------${snapshot.data}');
                                              //     debugPrint('$_details}');
                                              //     if (snapshot.data != null) {
                                              //       return CachedNetworkImage(
                                              //         imageUrl:
                                              //             '${snapshot.data}',
                                              //         imageBuilder: (context,
                                              //                 imageProvider) =>
                                              //             Container(
                                              //           margin: const EdgeInsets
                                              //               .all(5),
                                              //           decoration:
                                              //               BoxDecoration(
                                              //             image:
                                              //                 DecorationImage(
                                              //               image:
                                              //                   imageProvider,
                                              //               fit: BoxFit.contain,
                                              //             ),
                                              //           ),
                                              //         ),
                                              //         placeholder:
                                              //             (context, url) =>
                                              //                 const Center(
                                              //           child:
                                              //               CircularProgressIndicator(
                                              //             color: Color.fromRGBO(
                                              //                 0, 0, 0, 1),
                                              //             backgroundColor:
                                              //                 Color.fromRGBO(
                                              //                     255,
                                              //                     255,
                                              //                     255,
                                              //                     1),
                                              //           ),
                                              //         ),
                                              //         errorWidget: (context,
                                              //                 url, error) =>
                                              //             Image.asset(
                                              //           'assets/not_found.png',
                                              //           fit: BoxFit.cover,
                                              //         ),
                                              //         fadeOutDuration:
                                              //             const Duration(
                                              //                 milliseconds:
                                              //                     500),
                                              //       );
                                              //     }
                                              //     return const Center(
                                              //       child:
                                              //           CupertinoActivityIndicator(
                                              //         radius: 15,
                                              //       ),
                                              //     );
                                              //   },
                                              //   future: _getDownloadLink(
                                              //       _details[index], index),
                                              // ),
                                            ),
                                            onTap: () {
                                              _findPath(
                                                  imageList[index], index);
                                            },
                                          ),
                                          ((isSelected.isNotEmpty)
                                                  ? (isSelected[index] != '')
                                                  : false)
                                              ? const Align(
                                                  alignment: Alignment.topRight,
                                                  child: Icon(
                                                    Icons.check_circle_rounded,
                                                    color: Color.fromRGBO(
                                                        0, 0, 255, 1),
                                                    fill: 1,
                                                    shadows: [
                                                      BoxShadow(
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 1),
                                                        blurRadius: 1,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const Center(child: CircularProgressIndicator()),
                        (selectedItems.isNotEmpty)
                            ? Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 20, 13),
                                alignment: Alignment.centerRight,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0, 0),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: OutlinedButton.icon(
                                    onPressed: () {
                                      // ignore: deprecated_member_use
                                      Share.shareFiles(selectedItems);
                                    },
                                    icon: const Icon(
                                      Icons.send,
                                      size: 32,
                                    ),
                                    label: Text(
                                      '${selectedItems.length}',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(255, 0, 0, 1),
                                        fontFamily: 'Signika',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1.25,
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(255, 255, 0, 1),
                                      side: const BorderSide(
                                        color: Color.fromRGBO(0, 0, 0, 1),
                                        width: 1.5,
                                      ),
                                      elevation: 5,
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 7, 20, 7),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.2),
                          offset: Offset(0, -1),
                          blurRadius: 1,
                        )
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        if (widget._interstitialAd != null &&
                            isIntAdsShown == false) {
                          isIntAdsShown = true;
                          widget._interstitialAd!.show();
                        }
                        if (waitTime > 0) {
                          isWaiting = true;
                          activateWaiting();
                        } else if (isAddingSticker == false) {
                          if (mounted) {
                            setState(() {
                              isAddingSticker = true;
                            });
                            addToWhatsApp(false);
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          // color: const Color.fromRGBO(37, 211, 107, 1),
                          color: const Color.fromRGBO(0, 128, 105, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isAddingSticker
                                ? const CupertinoActivityIndicator(
                                    color: Color.fromRGBO(255, 255, 255, 1),
                                  )
                                : Text(
                                    isWaiting && waitTime > 0
                                        ? 'Processing    ${(100 - waitTime * 10).truncate()}%'
                                        : waitTime.toInt() == 0
                                            ? 'Continue'
                                            : 'Add to WhatsApp',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      letterSpacing: 1,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
