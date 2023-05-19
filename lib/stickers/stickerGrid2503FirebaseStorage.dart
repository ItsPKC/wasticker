// import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:wasticker/wallpaperSetting.dart';

// import '../global.dart';
// import '../services/ad_state.dart';

// class StickerGrid extends StatefulWidget {
//   // final String _path;
//   final List stickerReferenceList;
//   final String packname;
//   const StickerGrid(this.packname, this.stickerReferenceList, {super.key});

//   @override
//   State<StickerGrid> createState() => _StickerGridState();
// }

// class _StickerGridState extends State<StickerGrid> {
//   var _details = [];
//   // To show the tick if selected
//   List<String> isSelected = [];
//   // list of selected items
//   List<String> selectedItems = [];
//   var imageList = [];
//   var downloadPath = '';
//   folderSetUp(thePath) async {
//     // final folderName = "WA Assist/Download";
//     // final directoryPath = Directory("storage/emulated/0/$folderName");
//     final directoryPath = Directory(thePath);
//     if (await directoryPath.exists()) {
//     } else {
//       debugPrint("not exist");
//       await directoryPath.create();
//     }
//     // downloadPath = '/storage/emulated/0/WA Assist/Download';
//     downloadPath = thePath;
//   }

//   copyImage(value) async {
//     // Here I have to put file name with extension like xyz.png
//     // In our case interpolation out already contains extension
//     await File(value).copy('$downloadPath/${File(value).path.split('/').last}');
//     debugPrint('${File(value)}');
//     debugPrint(File(value).path.split('/').last);

//     debugPrint('${File(value)}');
//     debugPrint(
//         '${await File('$downloadPath/${File(value).path.split('/').last}').exists()}');
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
//     String temp;
//     // to avoid re-request on setstate
//     if (imageList[index] == '') {
//       debugPrint('..........................Getting');
//       // In the case of firebase
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
//     // debugPrint('For Share = $selectedItems');
//     // debugPrint(isSelected);
//   }

//   @override
//   void initState() {
//     super.initState();
//     // folderSetUp(widget._path);
//     _details = widget.stickerReferenceList;
//     for (var element in _details) {
//       isSelected.add('');
//       imageList.add('');
//       debugPrint(element);
//     }
//   }

//   var cwn = chatWallpaper[chatWallpaperNumber];

//   manageColor(value) {
//     setState(() {
//       cwn = chatWallpaper[value];
//     });
//   }

//   final _cacheManager = DefaultCacheManager();

//   @override
//   void dispose() {
//     super.dispose();
//     _cacheManager.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var imageList = Directory(widget._path)
//     //     .listSync()
//     //     .map((item) => item.path)
//     //     .where((item) => item.endsWith(".jpg"))
//     //     .toList(growable: false);
//     return Scaffold(
//       appBar: AppBar(
//         // systemOverlayStyle: const SystemUiOverlayStyle(
//         //   statusBarColor: Color.fromRGBO(230, 0, 0, 1),
//         // ),
//         backgroundColor: const Color.fromRGBO(0, 128, 105, 1),
//         actions: [
//           GestureDetector(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => WallPaperSetting(manageColor),
//               );
//             },
//             child: const SizedBox(
//               height: 56,
//               width: 56,
//               child: Icon(
//                 Icons.color_lens_rounded,
//                 color: Colors.white,
//                 size: 32,
//               ),
//             ),
//           ),
//         ],
//         titleSpacing: 0,
//         title: Text(
//           widget.packname,
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           textAlign: TextAlign.left,
//           style: const TextStyle(
//             color: Color.fromRGBO(255, 255, 255, 1),
//             fontWeight: FontWeight.w500,
//             fontSize: 18,
//             letterSpacing: 1,
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: WillPopScope(
//           key: Key(buildKey),
//           onWillPop: () => _onBackPressed(),
//           child: RefreshIndicator(
//             onRefresh: () => _refreshNow(),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: cwn['wallpaper'] as Color,
//                 image: DecorationImage(
//                   image: const AssetImage('assets/ChatWallpaper.png'),
//                   fit: BoxFit.cover,
//                   opacity: cwn['opacity'] as double,
//                 ),
//                 // gradient: LinearGradient(
//                 //   colors: [
//                 //     Color.fromRGBO(247, 226, 210, 0.6),
//                 //     Color.fromRGBO(247, 226, 210, 0.6),
//                 //     // Color.fromRGBO(242, 242, 242, 1),
//                 //   ],
//                 //   begin: Alignment.bottomLeft,
//                 //   end: Alignment.topCenter,
//                 // ),
//               ),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Stack(
//                       children: [
//                         (_details.isNotEmpty)
//                             ? GridView.builder(
//                                 physics: const AlwaysScrollableScrollPhysics(),
//                                 itemCount: _details.length,
//                                 gridDelegate:
//                                     const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 3,
//                                   // childAspectRatio: (MediaQuery.of(context).size.width - 15) /
//                                   //     (MediaQuery.of(context).size.height - 15),
//                                   childAspectRatio: 1,
//                                   crossAxisSpacing: 20,
//                                   mainAxisSpacing: 20,
//                                 ),
//                                 padding:
//                                     const EdgeInsets.fromLTRB(15, 20, 15, 80),
//                                 itemBuilder: (context, index) {
//                                   return Container(
//                                     decoration: const BoxDecoration(
//                                       borderRadius: BorderRadius.all(
//                                         Radius.circular(3),
//                                       ),
//                                       // boxShadow: [
//                                       //   BoxShadow(
//                                       //     color: Color.fromRGBO(0, 0, 0, 0.1),
//                                       //     blurRadius: 1,
//                                       //     offset: Offset(0, 0.5),
//                                       //   ),
//                                       // ],
//                                     ),

//                                     // index is item - 1
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(3),
//                                       child: Stack(
//                                         children: [
//                                           GestureDetector(
//                                             child: Container(
//                                               // color: const Color.fromRGBO(
//                                               //     255, 255, 255, 1),
//                                               color: Colors.transparent,
//                                               alignment: Alignment.topCenter,
//                                               child: FutureBuilder(
//                                                 builder: (context, snapshot) {
//                                                   // .......................
//                                                   debugPrint(
//                                                       '//-----------------------------${snapshot.data}');
//                                                   debugPrint('$_details}');
//                                                   if (snapshot.data != null) {
//                                                     return CachedNetworkImage(
//                                                       imageUrl:
//                                                           '${snapshot.data}',
//                                                       imageBuilder: (context,
//                                                               imageProvider) =>
//                                                           Container(
//                                                         margin: const EdgeInsets
//                                                             .all(5),
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           image:
//                                                               DecorationImage(
//                                                             image:
//                                                                 imageProvider,
//                                                             fit: BoxFit.contain,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       placeholder:
//                                                           (context, url) =>
//                                                               const Center(
//                                                         child:
//                                                             CircularProgressIndicator(
//                                                           color: Color.fromRGBO(
//                                                               0, 0, 0, 1),
//                                                           backgroundColor:
//                                                               Color.fromRGBO(
//                                                                   255,
//                                                                   255,
//                                                                   255,
//                                                                   1),
//                                                         ),
//                                                       ),
//                                                       errorWidget: (context,
//                                                               url, error) =>
//                                                           Image.asset(
//                                                         'assets/not_found.png',
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                     );
//                                                   }
//                                                   return const Center(
//                                                     child:
//                                                         CupertinoActivityIndicator(
//                                                       radius: 15,
//                                                     ),
//                                                   );
//                                                 },
//                                                 future: _getDownloadLink(
//                                                     _details[index], index),
//                                               ),
//                                             ),
//                                             onTap: () {
//                                               // Navigator.push(
//                                               //   context,
//                                               //   MaterialPageRoute(
//                                               //     builder: (context) =>
//                                               //         ViewImage(imageList[index]),
//                                               //   ),
//                                               // );{
//                                               _findPath(
//                                                   imageList[index], index);
//                                             },
//                                           ),
//                                           ((isSelected.isNotEmpty)
//                                                   ? (isSelected[index] != '')
//                                                   : false)
//                                               ? const Align(
//                                                   alignment: Alignment.topRight,
//                                                   child: Icon(
//                                                     Icons.check_circle_rounded,
//                                                     color: Color.fromRGBO(
//                                                         0, 0, 255, 1),
//                                                     fill: 1,
//                                                     shadows: [
//                                                       BoxShadow(
//                                                         color: Color.fromRGBO(
//                                                             255, 255, 255, 1),
//                                                         blurRadius: 1,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 )
//                                               : Container(),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               )
//                             : const Center(child: CircularProgressIndicator()),
//                         (selectedItems.isNotEmpty)
//                             ? Container(
//                                 margin: const EdgeInsets.fromLTRB(0, 0, 20, 13),
//                                 // padding: EdgeInsets.all(5),
//                                 alignment: Alignment.centerRight,
//                                 child: Container(
//                                   decoration: const BoxDecoration(
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey,
//                                         offset: Offset(0, 0),
//                                         blurRadius: 10,
//                                       ),
//                                     ],
//                                   ),
//                                   child: OutlinedButton.icon(
//                                     onPressed: () {
//                                       // ignore: deprecated_member_use
//                                       Share.shareFiles(selectedItems);
//                                     },
//                                     icon: const Icon(
//                                       Icons.send,
//                                       size: 32,
//                                     ),
//                                     label: Text(
//                                       '${selectedItems.length}',
//                                       style: const TextStyle(
//                                         color: Color.fromRGBO(255, 0, 0, 1),
//                                         fontFamily: 'Signika',
//                                         fontSize: 24,
//                                         fontWeight: FontWeight.w600,
//                                         letterSpacing: 1.25,
//                                       ),
//                                     ),
//                                     style: OutlinedButton.styleFrom(
//                                       // primary: const Color.fromRGBO(0, 0, 255, 1),
//                                       backgroundColor:
//                                           const Color.fromRGBO(255, 255, 0, 1),
//                                       side: const BorderSide(
//                                         color: Color.fromRGBO(0, 0, 0, 1),
//                                         width: 1.5,
//                                       ),
//                                       elevation: 5,
//                                       padding: const EdgeInsets.fromLTRB(
//                                           20, 7, 20, 7),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             : Container(),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
//                     decoration: const BoxDecoration(
//                       color: Color.fromRGBO(255, 255, 255, 1),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color.fromRGBO(0, 0, 0, 0.2),
//                           offset: Offset(0, -1),
//                           blurRadius: 1,
//                         )
//                       ],
//                     ),
//                     child: Container(
//                       height: 50,
//                       alignment: Alignment.center,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         // color: const Color.fromRGBO(37, 211, 107, 1),
//                         color: const Color.fromRGBO(0, 128, 105, 1),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(3),
//                             margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: const Color.fromRGBO(255, 255, 255, 1),
//                               ),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: const Icon(
//                               Icons.add,
//                               color: Colors.white,
//                             ),
//                           ),
//                           const Expanded(
//                             child: Center(
//                               child: Text(
//                                 'Add to WhatsApp',
//                                 style: TextStyle(
//                                   color: Color.fromRGBO(255, 255, 255, 1),
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 16,
//                                   letterSpacing: 1,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
