// import 'dart:async';
// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// // import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:waassist/services/ad_state.dart';
// import 'package:whatsapp_stickers/exceptions.dart';
// import 'package:whatsapp_stickers/whatsapp_stickers.dart';

// // import 'package:whatsapp_stickers/exceptions.dart';
// // import 'package:whatsapp_stickers/whatsapp_stickers.dart';

// class StickerGrid extends StatefulWidget {
//   // final String _path;
//   final stickerReferenceList;

//   StickerGrid(this.stickerReferenceList);

//   @override
//   _StickerGridState createState() => _StickerGridState();
// }

// class _StickerGridState extends State<StickerGrid> {
//   var _details = [];

//   // To show the tick if selected
//   List<String> isSelected = [];

//   // list of selected items
//   List<String> selectedItems = [];
//   var imageList = [];
//   var downloadPath = '';

//   // -----------------------------------------------

//   // for temporary storage of all current pics
//   // var stickersDirectory;
//   // List<String> stickers = [];

//   // folderSetUp() async {
//   //   var applicationDocumentsDirectory =
//   //       await getApplicationDocumentsDirectory();
//   //   stickersDirectory =
//   //       Directory('${applicationDocumentsDirectory.path}/stickers');
//   //   if (await stickersDirectory.exists()) {
//   //     await stickersDirectory.delete();
//   //     await stickersDirectory.create(recursive: true);
//   //   } else {
//   //     await stickersDirectory.create(recursive: true);
//   //   }
//   // }

//   // addImageToTempDir(String imageUrl, index) async {
//   //   await DefaultCacheManager().getSingleFile(imageUrl).then(
//   //     (file) {
//   //       stickers.add('${stickersDirectory.path}/$index');
//   //       File(file.path).copy('${stickersDirectory.path}/$index');
//   //     },
//   //   );
//   // }

//   // -----------------------------------------------

//   // folderSetUp(_thePath) async {
//   //   // final folderName = "WA Assist/Download";
//   //   // final directoryPath = Directory("storage/emulated/0/$folderName");
//   //   final directoryPath = Directory(_thePath);
//   //   if (await directoryPath.exists()) {
//   //   } else {
//   //     print("not exist");
//   //     await directoryPath.create();
//   //   }
//   //   // downloadPath = '/storage/emulated/0/WA Assist/Download';
//   //   downloadPath = _thePath;
//   // }

//   copyImage(value) async {
//     // Here I have to put file name with extension like xyz.png
//     // In our case interpolation out already contains extension
//     await File(value).copy('$downloadPath/${File(value).path.split('/').last}');
//     print(File(value));
//     print(File(value).path.split('/').last);

//     print(File(value));
//     print(await File('$downloadPath/${File(value).path.split('/').last}')
//         .exists());
//     setState(() {});
//     // Please add any snack bar to confirm that download is completed
//   }

//   // Checking Whether image is downloaded or not
//   Future<int> checkIfDownloaded(value) async {
//     if (await File('$downloadPath/${File(value).path.split('/').last}')
//         .exists()) {
//       // print('${File(value).path.split('/').last} :: 1');
//       return 1;
//     } else {
//       return 0;
//     }
//   }

//   // Deleting Downloaded Image
//   Future<void> deleteIfDownloaded(value) async {
//     if (await File('$downloadPath/${File(value).path.split('/').last}')
//         .exists()) {
//       // print('${File(value).path.split('/').last} :: 1');
//       await File('$downloadPath/${File(value).path.split('/').last}').delete();
//     } else {}
//     setState(() {});
//   }

//   // refresh Page

//   var buildKey = '0';

//   Future<void> _refreshNow() async {
//     // selectedItems = [];
//     // isSelected.fillRange(0, isSelected.length, '');
//     // setState(() {});
//     // setState with new build key to reload everything;
//     setState(() {
//       buildKey = (int.parse(buildKey) + 1).toString();
//     });
//   }

//   _onBackPressed() {
//     if (selectedItems.isNotEmpty) {
//       selectedItems = [];
//       isSelected.fillRange(0, isSelected.length, '');
//       setState(() {});
//     } else {
//       Navigator.of(context).pop();
//     }
//   }

//   final firebase_storage.FirebaseStorage _storage =
//       FireStorageBucket().getInstance;

//   Future<String> _getDownloadLink(getLinkFrom, index) async {
//     var temp;
//     // to avoid re-request on setstate
//     if (imageList[index] == '') {
//       print('..........................Getting');
//       temp = await _storage.ref(getLinkFrom).getDownloadURL();
//       imageList[index] = temp;
//     } else {
//       return imageList[index];
//     }
//     return temp;
//   }

//   Future<void> _findPath(String imageUrl, index) async {
//     await DefaultCacheManager().getSingleFile(imageUrl).then(
//       (file) {
//         if (isSelected[index] == '') {
//           isSelected[index] = file.path;
//         } else {
//           isSelected[index] = '';
//         }
//         // To clear last list items and fill the refersh list
//         selectedItems.clear();
//         for (int i = 0; i < isSelected.length; i++) {
//           if (isSelected[i] != '') {
//             selectedItems.add(isSelected[i]);
//           }
//         }
//         setState(() {
//           isSelected[index] = isSelected[index];
//         });
//       },
//     );
//     // print('For Share = $selectedItems');
//     // print(isSelected);
//   }

//   @override
//   void initState() {
//     super.initState();
//     // folderSetUp();
//     _details = widget.stickerReferenceList;
//     for (var element in _details) {
//       isSelected.add('');
//       imageList.add('');
//       print(element);
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var imageList = Directory(widget._path)
//     //     .listSync()
//     //     .map((item) => item.path)
//     //     .where((item) => item.endsWith(".jpg"))
//     //     .toList(growable: false);
//     return WillPopScope(
//       key: Key(buildKey),
//       onWillPop: () => _onBackPressed(),
//       child: RefreshIndicator(
//         onRefresh: () => _refreshNow(),
//         child: Column(
//           children: [
//             Expanded(
//               child: Stack(
//                 children: [
//                   (_details.isNotEmpty)
//                       ? GridView.builder(
//                           physics: const AlwaysScrollableScrollPhysics(),
//                           itemCount: _details.length,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 3,
//                             // childAspectRatio: (MediaQuery.of(context).size.width - 15) /
//                             //     (MediaQuery.of(context).size.height - 15),
//                             childAspectRatio: 9 / 16,
//                           ),
//                           itemBuilder: (context, index) {
//                             return Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Color.fromRGBO(255, 0, 0, 1),
//                                   // width: 1.5,
//                                 ),
//                               ),
//                               // index is item - 1
//                               margin: (index % 3 == 0)
//                                   ? EdgeInsets.fromLTRB(10, 15, 5, 7.5)
//                                   : ((index % 3 == 1)
//                                       ? EdgeInsets.fromLTRB(5, 15, 5, 7.5)
//                                       : EdgeInsets.fromLTRB(5, 15, 10, 7.5)),
//                               child: Stack(
//                                 children: [
//                                   GestureDetector(
//                                     child: Container(
//                                       color: Color.fromRGBO(255, 255, 255, 1),
//                                       alignment: Alignment.topCenter,
//                                       child: FutureBuilder(
//                                         builder: (context, snapshot) {
//                                           if (snapshot.data != null) {
//                                             return CachedNetworkImage(
//                                               imageUrl: '${snapshot.data}',
//                                               imageBuilder:
//                                                   (context, imageProvider) {
//                                                 // addImageToTempDir(
//                                                 //     '${snapshot.data}', index);
//                                                 return Container(
//                                                   margin: EdgeInsets.all(5),
//                                                   decoration: BoxDecoration(
//                                                     image: DecorationImage(
//                                                       image: imageProvider,
//                                                       fit: BoxFit.contain,
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                               placeholder: (context, url) =>
//                                                   Center(
//                                                 child:
//                                                     CircularProgressIndicator(
//                                                   color: Color.fromRGBO(
//                                                       0, 0, 0, 1),
//                                                   backgroundColor:
//                                                       Color.fromRGBO(
//                                                           255, 255, 255, 1),
//                                                 ),
//                                               ),
//                                               errorWidget:
//                                                   (context, url, error) =>
//                                                       Image.asset(
//                                                 'assets/not_found.png',
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             );
//                                           }
//                                           return Center(
//                                             child: CupertinoActivityIndicator(
//                                               radius: 15,
//                                             ),
//                                           );
//                                         },
//                                         future: _getDownloadLink(
//                                             _details[index], index),
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       // Navigator.push(
//                                       //   context,
//                                       //   MaterialPageRoute(
//                                       //     builder: (context) =>
//                                       //         ViewImage(imageList[index]),
//                                       //   ),
//                                       // );{
//                                       _findPath(imageList[index], index);
//                                     },
//                                   ),
//                                   ((isSelected.isNotEmpty)
//                                           ? (isSelected[index] != '')
//                                           : false)
//                                       ? Align(
//                                           alignment: Alignment.topRight,
//                                           child: Icon(
//                                             Icons.check_circle_rounded,
//                                             color: Color.fromRGBO(0, 0, 255, 1),
//                                           ),
//                                         )
//                                       : Container(),
//                                 ],
//                               ),
//                             );
//                           },
//                         )
//                       : Center(child: CircularProgressIndicator()),
//                   (selectedItems.isNotEmpty)
//                       ? Container(
//                           margin: EdgeInsets.fromLTRB(0, 0, 20, 13),
//                           // padding: EdgeInsets.all(5),
//                           alignment: Alignment.centerRight,
//                           child: OutlinedButton.icon(
//                             onPressed: () {
//                               Share.shareFiles(selectedItems);
//                             },
//                             icon: Icon(
//                               Icons.send,
//                               size: 32,
//                             ),
//                             label: Text(
//                               '${selectedItems.length}',
//                               style: TextStyle(
//                                 color: Color.fromRGBO(255, 0, 0, 1),
//                                 fontFamily: 'Signika',
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.w600,
//                                 letterSpacing: 1.25,
//                               ),
//                             ),
//                             style: OutlinedButton.styleFrom(
//                               primary: Color.fromRGBO(0, 0, 255, 1),
//                               backgroundColor: Color.fromRGBO(255, 255, 0, 1),
//                               side: BorderSide(
//                                 color: Color.fromRGBO(0, 0, 0, 1),
//                                 width: 2,
//                               ),
//                               elevation: 5,
//                               padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
//                             ),
//                           ),
//                         )
//                       : Container(),
//                 ],
//               ),
//             ),
//             Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 child: Container(
//                   height: 50,
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: Color.fromRGBO(240, 255, 240, 1),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.grey,
//                         offset: Offset(0, -1),
//                         blurRadius: 3,
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/wa.png',
//                         height: 30,
//                         width: 30,
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Text(
//                         'Add to WhatsApp',
//                         style: TextStyle(
//                           color: Color.fromRGBO(0, 158, 96, 1),
//                           fontFamily: 'Signika',
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                           letterSpacing: 2,
//                           shadows: const [
//                             Shadow(
//                               color: Color.fromRGBO(255, 255, 255, 1),
//                               blurRadius: 2,
//                               offset: Offset(0, 0),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 onTap: () async {
//                   // var stickerPack = WhatsappStickers(
//                   //   identifier: 'asd',
//                   //   name: 'asd',
//                   //   publisher: 'John Doen',
//                   //   trayImageFileName:
//                   //       WhatsappStickerImage.fromAsset('tray_Cuppy.png'),
//                   //   publisherWebsite: '',
//                   //   privacyPolicyWebsite: '',
//                   //   licenseAgreementWebsite: '',
//                   // );

//                   // stickers.map((e) => stickerPack
//                   //     .addSticker(WhatsappStickerImage.fromFile(e), ['😐']));

//                   // try {
//                   //   await stickerPack.sendToWhatsApp();
//                   // } on WhatsappStickersException catch (e) {
//                   //   print(stickerPack);
//                   //   print(
//                   //       '____________________________________________________________________________');
//                   //   print(stickers);
//                   //   print(e.cause);
//                   //   print(
//                   //       '____________________________________________________________________________');
//                   // }

//                   // showDialog(
//                   //     context: context,
//                   //     builder: (context) => AlertDialog(
//                   //           content: Image.file(File(stickers[0])),
//                   //         ));
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
