// ignore_for_file: avoid_print

import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  Future<InitializationStatus> initialization;
  AdState(this.initialization);
  String get bannerAdUnitId1 => 'ca-app-pub-4788716700673911/4181685290';
  String get bannerAdUnitId2 => 'ca-app-pub-4788716700673911/7822343565';
  // Interstitials Ads
  // ID Used in List
  // String get intersAdUnitId1 => 'ca-app-pub-4788716700673911/5810708220';
  BannerAdListener get adListener => _adListener;
  final BannerAdListener _adListener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression is recorded for a NativeAd.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );
}

getDeviceSize(context) {
  return ((View.of(context).physicalSize.width /
              View.of(context).devicePixelRatio) -
          (View.of(context).physicalSize.width /
                  View.of(context).devicePixelRatio) %
              20)
      .truncate();
}

class Fire {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get getInstance {
    return _firestore;
  }
}

class FireStorageBucket {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseStorage get getInstance {
    return _storage;
  }
}

// class MyPermission {
//   var tempPerm = (myDeviceVersion > 29)
//       ? Permission.manageExternalStorage
//       : Permission.storage;
//   Permission get sdkBasedStoragePermission {
//     return tempPerm;
//   }
// }

// class TakePermission {
//   var context;
//   TakePermission(context) {
//     context = context;
//   }
//   Future<bool> get storage async {
//     var status = Permission.storage.status;
//     if (await status.isGranted) {
//       return true;
//     }
//     if (await status.isDenied) {
//       Permission.storage.request();
//     }
//     if (!(await status.isGranted)) {
//       Permission.storage.request();
//       return false;
//     }
//     if (await status.isPermanentlyDenied) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) {
//             return StoragePermissionDenied();
//           },
//         ),
//       );
//       return false;
//     }
//     return false;
//   }
// }
