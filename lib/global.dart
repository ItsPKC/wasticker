import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:in_app_review/in_app_review.dart';

// Obtain shared preferences.
SharedPreferences prefs = SharedPreferences.getInstance() as SharedPreferences;

// final InAppReview inAppReview = InAppReview.instance;

// setReviewRequestStatusData(val) async {
//   await prefs.setInt('lastReviewRequest', val);
// }

// getReviewRequestStatus() {
//   var lastReviewRequest =
//       prefs.getInt('lastReviewRequest') ?? DateTime.now().day;

//   if (prefs.getInt('lastReviewRequest') == null) {
//     setReviewRequestStatusData(lastReviewRequest);
//     return true;
//   }
//   if (DateTime.now().day - lastReviewRequest >= 3) {
//     return true;
//   }
//   return false;
// }

// requestAppReview() async {
//   debugPrint('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ App Review Requested');
//   if (getReviewRequestStatus()) {
//     debugPrint('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Checked review Status');
//     if (await inAppReview.isAvailable()) {
//       debugPrint('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ App Review Available');
//       Future.delayed(const Duration(milliseconds: 1000), () {
//         inAppReview.requestReview();
//       });
//     }
//   }
// }

var chatWallpaperNumber = prefs.getInt('chatWallpaperNumber') ?? 0;

List<Map<String, Object>> chatWallpaper = [
  {'wallpaper': const Color.fromRGBO(239, 230, 221, 1), 'opacity': 0.47},
  // Color.fromRGBO(243, 236, 229, 1),
  {'wallpaper': const Color.fromRGBO(187, 229, 228, 1), 'opacity': 0.3},
  {'wallpaper': const Color.fromRGBO(174, 217, 200, 1), 'opacity': 0.25},
  {'wallpaper': const Color.fromRGBO(122, 202, 165, 1), 'opacity': 0.3},
  {'wallpaper': const Color.fromRGBO(203, 218, 237, 1), 'opacity': 0.35},
  {'wallpaper': const Color.fromRGBO(102, 210, 213, 1), 'opacity': 0.3},
  {'wallpaper': const Color.fromRGBO(100, 189, 207, 1), 'opacity': 0.22},
  {'wallpaper': const Color.fromRGBO(213, 208, 240, 1), 'opacity': 0.3},
  {'wallpaper': const Color.fromRGBO(206, 206, 206, 1), 'opacity': 0.325},
  {'wallpaper': const Color.fromRGBO(209, 218, 191, 1), 'opacity': 0.35},
  {'wallpaper': const Color.fromRGBO(229, 225, 177, 1), 'opacity': 0.45},
  {'wallpaper': const Color.fromRGBO(254, 240, 169, 1), 'opacity': 0.85},
  {'wallpaper': const Color.fromRGBO(254, 209, 150, 1), 'opacity': 0.38},
  {'wallpaper': const Color.fromRGBO(253, 155, 156, 1), 'opacity': 0.18},
  {'wallpaper': const Color.fromRGBO(253, 103, 105, 1), 'opacity': 0.27},
  {'wallpaper': const Color.fromRGBO(251, 70, 103, 1), 'opacity': 0.26},
  {'wallpaper': const Color.fromRGBO(146, 32, 65, 1), 'opacity': 0.175},
  {'wallpaper': const Color.fromRGBO(220, 109, 79, 1), 'opacity': 0.175},
  {'wallpaper': const Color.fromRGBO(99, 76, 82, 1), 'opacity': 0.105},
  {'wallpaper': const Color.fromRGBO(81, 127, 127, 1), 'opacity': 0.125},
  {'wallpaper': const Color.fromRGBO(48, 143, 187, 1), 'opacity': 0.14},
  {'wallpaper': const Color.fromRGBO(53, 84, 138, 1), 'opacity': 0.11},
  {'wallpaper': const Color.fromRGBO(85, 99, 112, 1), 'opacity': 0.12},
  {'wallpaper': const Color.fromRGBO(30, 35, 39, 1), 'opacity': 0.12},
  {'wallpaper': const Color.fromRGBO(48, 30, 52, 1), 'opacity': 0.1},
  {'wallpaper': const Color.fromRGBO(229, 233, 234, 1), 'opacity': 0.8},
  //  {Color.fromRGBO(255, 254, 162, 1),
  {'wallpaper': const Color.fromRGBO(230, 232, 210, 1), 'opacity': 0.55},
];

final defaultCacheManager = DefaultCacheManager();
var stickerAdditionTimeController =
    prefs.getInt('stickerAdditionTimeController') ??
        (DateTime.now().millisecondsSinceEpoch - 31000);

Future<void> makeRequest(url, context) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.none) {
    try {
      // ignore: deprecated_member_use
      if (await canLaunch(url)) {
        // ignore: deprecated_member_use
        await launch(url);
      } else {
        debugPrint('Can\'t lauch now !!!');
      }
    } catch (e) {
      debugPrint('$e');
    }
  } else {
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('WA Assist'),
          content: const Text(
            'No Internet connection .',
            style: TextStyle(
              fontFamily: 'Signika',
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 1,
              color: Color.fromRGBO(255, 0, 0, 1),
            ),
          ),
          actions: <Widget>[
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
