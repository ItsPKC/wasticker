// ignore: file_names
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import 'package:wasticker/stickers/stickerGrid.dart';
import 'package:collection/collection.dart';
import '../navigation/updateApp.dart';
import '../services/ad_state.dart';

class StickerHome extends StatefulWidget {
  const StickerHome({super.key});

  @override
  State<StickerHome> createState() => _StickerHomeState();
}

class _StickerHomeState extends State<StickerHome> {
  final _packList = [];

  // Ads variable
  var adsList = [];
  var adsListLengthStart = 0;
  var adsListLength = 0;

  var isRefDataAvailable = false;
  var _refRound = 2;

  // It can't be less than 2. Tt set according to request condition.
  var loadingNextRound = false;
  final _scrollController = ScrollController();

  // final FirebaseStorage _storage = FireStorageBucket().getInstance;

  Future<String> _getDownloadLink(getLinkFrom) async {
    debugPrint('..........................Getting');
    // In the case of firestore
    // var temp = await _storage.ref(getLinkFrom).getDownloadURL();
    // In the case of dpgram.in
    var temp = 'https://dpgram.in/kingmaker/$getLinkFrom';
    return temp;
  }

  // Ads - Start

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context, listen: false);
    adState.initialization.then(
      (status) {
        if (mounted) {
          setState(
            () {
              var w2 = getDeviceSize(context) - 30;
              // 80 for default margin and 20 for internal padding
              var h2 = (0.7 * w2).truncate();
              for (int i = adsListLengthStart; i < adsListLength; i++) {
                if (i % 9 != 0) {
                  adsList.insert(i, '');
                } else {
                  adsList.insert(
                    i,
                    BannerAd(
                      adUnitId: adState.bannerAdUnitId1,
                      size: AdSize(
                        height: h2,
                        width: w2,
                      ),
                      request: const AdRequest(),
                      // listener: adState.adListener,
                      listener: myAdListener(i),
                    )..load(),
                  );
                }
              }
              // It is for filling those placed where ads failed to load
              // Re-request Ads will happen when load more data is requested
              for (int i = 0; i < adsListLength; i++) {
                if (i % 9 == 0 && adsList[i] == 'adsFailedtoLoad') {
                  // Here we have to replace. Not to insert as a new one.
                  adsList[i] = BannerAd(
                    adUnitId: adState.bannerAdUnitId2,
                    size: AdSize(
                      height: h2,
                      width: w2,
                    ),
                    request: const AdRequest(),
                    // listener: adState.adListener,
                    listener: myAdListener(i),
                  )..load();
                }
              }
            },
          );
        }
      },
    );
  }

  myAdListener(takeAdListAddress) {
    BannerAdListener adListener = BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) =>
          debugPrint('Banner ad loaded : $takeAdListAddress.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        debugPrint('Ad failed to load: $error');
        setState(() {
          adsList[takeAdListAddress] = 'adsFailedtoLoad';
        });
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => debugPrint('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => debugPrint('Ad closed.'),
    );
    return adListener;
  }

  // ------Int Ads------
  InterstitialAd? _interstitialAd;
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-4788716700673911/7354643540'
      : 'ca-app-pub-4788716700673911/6097950939';

  /// Loads an interstitial ad.
  void loadAd() {
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {
              _interstitialAd = null;
            },

            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {},

            // Called when the ad failed to show full screen content.
            onAdFailedToShowFullScreenContent: (ad, err) {
              _interstitialAd = null;
              // Dispose the ad here to free resources.
              ad.dispose();
            },

            // Called when the ad dismissed full screen content.
            onAdDismissedFullScreenContent: (ad) {
              _interstitialAd = null;
              // Dispose the ad here to free resources.
              ad.dispose();
            },

            // Called when a click is recorded for an ad.
            onAdClicked: (ad) {},
          );
          debugPrint('Int ads loaded : $ad');

          // Keep a reference to the ad so you can show it later.
          _interstitialAd = ad;
        },

        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }
  // -------------------

  // Ads - End

  myGrid(data, currentGoingStickerFolderNumber) {
    return GestureDetector(
      child: Container(
        height: (MediaQuery.of(context).size.width - 20) * 0.3 + 36,
        // width: MediaQuery.of(context).size.width * 0.5 - 20,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1),
          borderRadius: BorderRadius.circular(5),
          // border: Border.all(
          //   color: Color.fromRGBO(255, 0, 0, 1),
          //   width: 1.5,
          // ),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 0.5),
              blurRadius: 0.5,
            ),
          ],
        ),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Container(
              height: 36,
              // alignment: Alignment.bottomCenter,
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.05),
                borderRadius: BorderRadius.circular(3.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data["packname"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Signika',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    "${data["content"].length} N",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Signika',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(0, 0, 0, 1),
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      // child: CachedNetworkImage(
                      //   imageUrl: '${_getDownloadLink(data["icon"][0])}',
                      //   imageBuilder: (context, imageProvider) => Container(
                      //     decoration: BoxDecoration(
                      //       image: DecorationImage(
                      //         image: imageProvider,
                      //         fit: BoxFit.contain,
                      //       ),
                      //     ),
                      //   ),
                      //   placeholder: (context, url) => const Center(
                      //     child: CircularProgressIndicator(
                      //       color: Color.fromRGBO(0, 0, 0, 1),
                      //       backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                      //     ),
                      //   ),
                      //   errorWidget: (context, url, error) => Image.asset(
                      //     'assets/not_found.png',
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      child: FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return CachedNetworkImage(
                              imageUrl: '${snapshot.data}',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  backgroundColor:
                                      Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  // Image.asset(
                                  //   'assets/not_found.png',
                                  //   fit: BoxFit.cover,
                                  // ),
                                  Container(
                                alignment: Alignment.center,
                                color: const Color.fromRGBO(0, 0, 0, 0.05),
                                child: const Icon(
                                  Icons.download_rounded,
                                  color: Color.fromRGBO(0, 128, 105, 0.5),
                                  size: 32,
                                ),
                              ),
                            );
                          }
                          return const CupertinoActivityIndicator(
                            radius: 15,
                          );
                        },
                        future: _getDownloadLink(data["icon"][0]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      // child: Image.asset('assets/cat2.webp'),
                      child: FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return CachedNetworkImage(
                              imageUrl: '${snapshot.data}',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  backgroundColor:
                                      Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  //  Image.asset(
                                  //   'assets/not_found.png',
                                  //   fit: BoxFit.cover,
                                  // ),
                                  Container(
                                alignment: Alignment.center,
                                color: const Color.fromRGBO(0, 0, 0, 0.05),
                                child: const Icon(
                                  Icons.download_rounded,
                                  color: Color.fromRGBO(0, 128, 105, 0.5),
                                  size: 32,
                                ),
                              ),
                            );
                          }
                          return const CupertinoActivityIndicator(
                            radius: 15,
                          );
                        },
                        future: _getDownloadLink(data["icon"][1]),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      // child: Image.asset('assets/cat2.webp'),
                      child: FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return CachedNetworkImage(
                              imageUrl: '${snapshot.data}',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  backgroundColor:
                                      Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  // Image.asset(
                                  //   'assets/not_found.png',
                                  //   fit: BoxFit.cover,
                                  // ),
                                  Container(
                                alignment: Alignment.center,
                                color: const Color.fromRGBO(0, 0, 0, 0.05),
                                child: const Icon(
                                  Icons.download_rounded,
                                  color: Color.fromRGBO(0, 128, 105, 0.5),
                                  size: 32,
                                ),
                              ),
                            );
                          }

                          return const CupertinoActivityIndicator(
                            radius: 15,
                          );
                        },
                        future: _getDownloadLink(data["icon"][2]),
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Icon(
                        Icons.navigate_next_rounded,
                        // Icons.next_week_rounded,
                        color: Color.fromRGBO(220, 0, 0, 1),
                        size: 48,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        // showDialog(
        //   context: context,
        //   builder: (context) => Container(
        //     // margin:
        //     //     EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5),
        //     color: const Color.fromRGBO(255, 255, 255, 1),
        //     child: StickerGrid(data['packname'], data["content"]),
        //   ),
        // );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                StickerGrid(data['packname'], data["content"], _interstitialAd),
          ),
        );
      },
    );
  }

  final FirebaseFirestore _firestore = Fire().getInstance;

  getInitialRound() {
    setState(() {
      loadingNextRound = true;
    });
    debugPrint("lllllllllllllllllllllllllllllllllllllllllllllllllll");
    try {
      _firestore.collection('stickers').doc("AAAsetRound").get().then((doc) {
        // +1 is added because , round move to decreasing side
        _refRound = doc.data()!["initialRound"] + 1;
        if (doc.data() != null) {
          // it will continue displaying until null receive
          if (loadingNextRound = true) {
            setState(() {
              loadingNextRound = false;
              // To give the start where we left to set State
              adsListLengthStart = adsListLength;
              adsListLength = _packList.length;
              didChangeDependencies();
            });
          }
        }
      }).then((_) {
        getRefData();
      });
    } catch (error) {
      debugPrint(
          '(((((((((((((((((((((((((((((((((((((((())))))))))))))))))))))))))))))))))))))))');
      debugPrint('error');
    }
  }

  getRefData() async {
    if (_refRound >= 2 && loadingNextRound == false) {
      setState(() {
        loadingNextRound = true;
      });
      try {
        _firestore
            .collection('stickers')
            .doc("round${(_refRound - 1)}")
            .get()
            .then(
          (doc) {
            if (doc.data() != null) {
              _refRound = doc.data()!["round"];
              var tempList = doc.data()!["refData"];
              // It uses to reverse the list of string and then make a
              // tempList.reversed.toList();
              setState(() {
                _packList.addAll(tempList.reversed.toList());
                loadingNextRound = false;

                // To give the start where we left to set State
                adsListLengthStart = adsListLength;
                adsListLength = _packList.length;
                didChangeDependencies();
              });
              debugPrint('$_refRound');
              debugPrint('......................................$_packList');
              debugPrint('......................................$_refRound');
            } else {
              debugPrint('.....................................${doc.data()}');
            }
          },
        );
      } catch (error) {
        debugPrint(
            '2(((((((((((((((((((((((((((((((((((((((())))))))))))))))))))))))))))))))))))))))');
        debugPrint('Error');
      }
    }
  }

  var isUpdateAvailable = false;

  checkForUpdate() async {
    // Query q = _firestore.collection('updateApp');
    // QuerySnapshot querySnapshot = await q.get();
    // DocumentSnapshot a = querySnapshot.docs[0];
    // var _updatedVersion = a.data() as Map;
    // var updatedVersion = _updatedVersion['version'];
    // var _notice = a.data() as Map;
    // var notice = _notice['noticeNew'];

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    try {
      _firestore.collection('updateAppWAS').get().then(
        (QuerySnapshot querySnapshot) {
          for (var doc in querySnapshot.docs) {
            debugPrint(
                '======================================== ${doc["version"]}');
            var updatedVersion = '${doc["version"]}';
            var notice = '${doc["notice"]}';
            debugPrint(
                'Its verion 00000000000000000000000000000 $updatedVersion $currentVersion');
            debugPrint('Its notice ------------------------------- $notice');
            if (updatedVersion != currentVersion) {
              // pageNumberSelector(1);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UpdateApp(
                    '${doc["date"]}', '${doc["appLink"]}', '${doc["notice"]}');
              }));
            }
          }
        },
      );
    } catch (error) {
      debugPrint('Update check Error');
    }
  }

  @override
  void initState() {
    super.initState();
    // getRefData();
    getInitialRound();
    _scrollController.addListener(() {
      if ((_scrollController.position.pixels >=
          (_scrollController.position.maxScrollExtent -
              MediaQuery.of(context).size.height * 2))) {
        getRefData();
      }
    });
    loadAd();
    checkForUpdate();
    // requestAppReview();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    if (_interstitialAd != null) {
      _interstitialAd!.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('packList Length $_packList');
    debugPrint('packList Length ${_packList.length}');
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Column(
        children: [
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              children: [
                // ElevatedButton(
                //   onPressed: () {
                //     showDialog(
                //       context: context,
                //       builder: (context) => Container(
                //         margin: EdgeInsets.only(
                //             top: MediaQuery.of(context).size.height * 0.5),
                //         color: Colors.amber,
                //         // child: StickerGrid1(_packList[0]['content']), //correct
                //         child: StickerGrid(
                //             _packList[0]['content']), // to remove error
                //       ),
                //     );
                //   },
                //   child: Text('Text Button'),
                // ),
                ..._packList.mapIndexed(
                    // (index, element) => myGrid(element, 0),
                    (index, element) {
                  if (index % 9 == 0) {
                    return Column(
                      children: [
                        Container(
                          height:
                              0.7 * (getDeviceSize(context) - 20).truncate(),
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          color: const Color.fromRGBO(0, 255, 0, 0.2),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Ads',
                                    style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      fontFamily: 'Signika',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.25,
                                    ),
                                  ),
                                ),
                              ),
                              if (adsList.isNotEmpty &&
                                  adsList[index] != 'adsFailedtoLoad')
                                // it may couse adsense account ban
                                AdWidget(
                                  ad: adsList[index],
                                ),
                            ],
                          ),
                        ),
                        myGrid(element, 0),
                      ],
                    );
                  } else {
                    return myGrid(element, 0);
                  }
                }),
                (loadingNextRound == true)
                    ? Container(
                        alignment: Alignment.center,
                        height: 150,
                        width: double.infinity,
                        // child: Text(
                        //   'Loading ...',
                        //   style: TextStyle(
                        //     fontFamily: 'Signika',
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.w700,
                        //     letterSpacing: 2,
                        //   ),
                        // ),
                        child: const CircularProgressIndicator(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          // Expanded(
          //   child: ListView.separated(
          //     padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
          //     itemCount: _packList.length,
          //     itemBuilder: (context, index) => myGrid(_packList[index], index),
          //     separatorBuilder: (context, index) {
          //       return (index % 9 == 0)
          //           ? Container(
          //               height: 0.7 * (GetDeviceSize.myWidth - 20).truncate(),
          //               margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          //               color: Colors.tealAccent,
          //               child: (adsList.isNotEmpty &&
          //                       adsList[index] != 'adsFailedtoLoad')
          //                   // it may couse adsense account ban
          //                   ? AdWidget(
          //                       ad: adsList[index],
          //                     )
          //                   : Container(
          //                       padding: EdgeInsets.all(5),
          //                       color: Colors.blue,
          //                       child: Center(
          //                         child: Text('Keep Learning ...'),
          //                       ),
          //                     ),
          //             )
          //           : Container();
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
