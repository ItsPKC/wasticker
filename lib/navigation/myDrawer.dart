// import 'dart:math';
// import '../services/MyAuth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../global.dart';
// import 'setting.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final tempBalance = 102.75;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
              child: ListView(
                children: [
                  // Start of heading container
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.25,
                  //   child: Stack(
                  //     children: [
                  //       Container(
                  //         width: double.infinity,
                  //         height: MediaQuery.of(context).size.height * 0.25,
                  //         decoration: BoxDecoration(
                  //           gradient: SweepGradient(
                  //             colors: const [
                  //               Color.fromRGBO(255, 0, 0, 1),
                  //               // Colors.red,
                  //               Colors.tealAccent,
                  //               Colors.orange,
                  //               // Color.fromRGBO(255, 153, 0, 1),
                  //             ],
                  //             stops: const [0, 0.35, 1],
                  //           ),
                  //         ),
                  //         child: null,
                  //       ),
                  //       Column(
                  //         children: [
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Container(
                  //                 margin: EdgeInsets.only(
                  //                   top: 7,
                  //                   bottom: 10,
                  //                   left: 7,
                  //                 ),
                  //                 child: CircleAvatar(
                  //                   backgroundColor: Colors.transparent,
                  //                   maxRadius:
                  //                       // (MediaQuery.of(context).size.height * 0.2 - 61- 17)/2,
                  //                       MediaQuery.of(context).size.height * 0.125 -
                  //                           39,
                  //                   backgroundImage: NetworkImage(
                  //                     'https://image.freepik.com/free-vector/rose-bouquet-illustration_1284-20872.jpg',
                  //                   ),
                  //                 ),
                  //               ),
                  //               // Container(
                  //               //   decoration: BoxDecoration(
                  //               //     gradient: RadialGradient(
                  //               //       colors: const [
                  //               //         Color.fromRGBO(0, 0, 0, 1),
                  //               //         Color.fromRGBO(0, 0, 0, 0.5),
                  //               //         Colors.transparent,
                  //               //       ],
                  //               //       stops: const [0.25, 0.6, 0.85],
                  //               //     ),
                  //               //   ),
                  //               //   margin: EdgeInsets.only(
                  //               //     top: 2,
                  //               //     right: 2,
                  //               //     bottom: 10,
                  //               //   ),
                  //               //   child: IconButton(
                  //               //     icon: Icon(
                  //               //       Icons.settings,
                  //               //       size: 26,
                  //               //       color: Color.fromRGBO(255, 255, 255, 1),
                  //               //     ),
                  //               //     onPressed: () {
                  //               //       // Navigator.pop(context);
                  //               //       // Navigator.of(context).pop();
                  //               //       Navigator.push(
                  //               //         context,
                  //               //         MaterialPageRoute(
                  //               //           builder: (context) => MySetting(),
                  //               //         ),
                  //               //       );
                  //               //     },
                  //               //   ),
                  //               // ),
                  //             ],
                  //           ),
                  //           Container(
                  //             width: double.infinity,
                  //             // margin: EdgeInsets.only(
                  //             //   right: 7,
                  //             // ),
                  //             padding: EdgeInsets.only(
                  //               top: 3,
                  //               right: 3,
                  //               bottom: 4,
                  //               left: 4,
                  //             ),
                  //             color: Color.fromRGBO(0, 0, 0, 0.7),
                  //             child: Column(
                  //               children: [
                  //                 SizedBox(
                  //                   width: double.infinity,
                  //                   height: 28,
                  //                   child: FittedBox(
                  //                     alignment: Alignment.centerLeft,
                  //                     child: Text(
                  //                       "Pankaj Kumar Choudhary",
                  //                       style: TextStyle(
                  //                         fontSize: 28,
                  //                         fontFamily: 'Signika',
                  //                         fontWeight: FontWeight.w700,
                  //                         letterSpacing: 1.5,
                  //                         color: Color.fromRGBO(255, 255, 255, 1),
                  //                         // shadows: [
                  //                         //   Shadow(
                  //                         //     color: Color.fromRGBO(0, 0, 0, 1),
                  //                         //     blurRadius: 20,
                  //                         //   ),
                  //                         // ],
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Container(
                  //                   width: double.infinity,
                  //                   margin: EdgeInsets.only(
                  //                     top: 3,
                  //                   ),
                  //                   child: Text(
                  //                     "pankaj.200kr@gmail.com",
                  //                     style: TextStyle(
                  //                       fontSize: 16,
                  //                       fontFamily: 'Signika',
                  //                       fontWeight: FontWeight.w500,
                  //                       letterSpacing: 1,
                  //                       color: Color.fromRGBO(255, 255, 255, 1),
                  //                       // shadows: [
                  //                       //   Shadow(
                  //                       //     color: Color.fromRGBO(0, 0, 0, 1),
                  //                       //     blurRadius: 20,
                  //                       //   ),
                  //                       // ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // End of Heading Container
                  // Divider(),
                  // Container(
                  //   color: Color.fromRGBO(0, 255, 0, 0.075),
                  //   padding: EdgeInsets.symmetric(
                  //     horizontal: 8,
                  //     vertical: 3,
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       FittedBox(
                  //         child: Row(
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             Icon(
                  //               Icons.monetization_on_sharp,
                  //               color: Color.fromRGBO(255, 153, 0, 1),
                  //               size: 48,
                  //             ),
                  //             Text(
                  //               ' $tempBalance',
                  //               style: TextStyle(
                  //                 fontSize: 36,
                  //                 fontFamily: 'Signika',
                  //                 fontWeight: FontWeight.w700,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       IconButton(
                  //         icon: Icon(
                  //           Icons.account_balance_wallet,
                  //           size: 32,
                  //           color: Color.fromRGBO(0, 128, 255, 1),
                  //         ),
                  //         onPressed: () {},
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // ListTile(
                  //   title: Text(
                  //     // "Accounts",
                  //     "Join us @",
                  //     style: TextStyle(
                  //       fontSize: 22,
                  //       fontFamily: 'Signika',
                  //       letterSpacing: 1,
                  //       fontWeight: FontWeight.w700,
                  //     ),
                  //   ),
                  //   tileColor: Color.fromRGBO(0, 255, 0, 0.075),
                  //   // trailing: Icon(
                  //   //   Icons.add_box_rounded,
                  //   //   size: 32,
                  //   //   color: Color.fromRGBO(0, 128, 255, 1),
                  //   // ),
                  // ),
                  // ListTile(
                  //   title: Text(
                  //     "Twitter",
                  //     style: TextStyle(
                  //       fontSize: 17,
                  //       fontFamily: 'Signika',
                  //       letterSpacing: 0.75,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  //   // trailing: Icon(Icons.check_circle_outline_rounded),
                  //   trailing: Icon(Icons.arrow_forward_ios_rounded),
                  //   dense: true,
                  // ),
                  // ListTile(
                  //   title: Text(
                  //     "Linkedin",
                  //     style: TextStyle(
                  //       fontSize: 17,
                  //       fontFamily: 'Signika',
                  //       letterSpacing: 0.75,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  //   // trailing: Icon(Icons.check_circle_outline_rounded),
                  //   trailing: Icon(Icons.arrow_forward_ios_rounded),
                  //   dense: true,
                  // ),
                  // ListTile(
                  //   title: Text(
                  //     "Facebook",
                  //     style: TextStyle(
                  //       fontSize: 17,
                  //       fontFamily: 'Signika',
                  //       letterSpacing: 0.75,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  //   // trailing: Icon(Icons.check_circle_outline_rounded),
                  //   trailing: Icon(Icons.arrow_forward_ios_rounded),
                  //   dense: true,
                  // ),
                  // ListTile(
                  //   title: Text(
                  //     "Instagram",
                  //     style: TextStyle(
                  //       fontSize: 17,
                  //       fontFamily: 'Signika',
                  //       letterSpacing: 0.75,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  //   // trailing: Icon(Icons.check_circle_outline_rounded),
                  //   trailing: Icon(Icons.arrow_forward_ios_rounded),
                  //   dense: true,
                  // ),
                  // Divider(),
                  // ListTile(
                  //   title: Text(
                  //     "Facebook Group",
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //       fontFamily: 'Signika',
                  //       letterSpacing: 1,
                  //       fontWeight: FontWeight.w700,
                  //     ),
                  //   ),
                  //   tileColor: Color.fromRGBO(0, 255, 0, 0.05),
                  //   trailing: Icon(
                  //     Icons.add_box_rounded,
                  //     size: 32,
                  //     color: Color.fromRGBO(0, 128, 255, 1),
                  //   ),
                  // ),
                  // Divider(),
                  // ListTile(
                  //   title: Text(
                  //     "Facebook Page",
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //       fontFamily: 'Signika',
                  //       letterSpacing: 1,
                  //       fontWeight: FontWeight.w700,
                  //     ),
                  //   ),
                  //   tileColor: Color.fromRGBO(0, 255, 0, 0.075),
                  //   trailing: Icon(
                  //     Icons.add_box_rounded,
                  //     size: 32,
                  //     color: Color.fromRGBO(0, 128, 255, 1),
                  //   ),
                  // ),
                  // Divider(),
                  // ListTile(
                  //   title: Text(
                  //     "Help Center",
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //       fontFamily: 'Signika',
                  //       letterSpacing: 1,
                  //       fontWeight: FontWeight.w700,
                  //     ),
                  //   ),
                  //   tileColor: Color.fromRGBO(255, 0, 0, 0.05),
                  //   trailing: Icon(
                  //     Icons.help_center_rounded,
                  //     size: 32,
                  //     color: Color.fromRGBO(255, 0, 0, 1),
                  //   ),
                  // ),
                  const Divider(),
                  GestureDetector(
                    child: const ListTile(
                      title: Text(
                        "Contact Us",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Signika',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      tileColor: Color.fromRGBO(255, 0, 0, 0.05),
                      trailing: Icon(
                        // Icons.feedback_rounded,
                        Icons.mail_rounded,
                        size: 30,
                        color: Color.fromRGBO(255, 0, 0, 1),
                      ),
                    ),
                    onTap: () {
                      makeRequest('mailto:contact@icyindia.com', context);
                    },
                  ),
                  const Divider(),
                  GestureDetector(
                    child: const ListTile(
                      title: Text(
                        // "Feedback",
                        "Term of use",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Signika',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      tileColor: Color.fromRGBO(255, 0, 0, 0.05),
                      trailing: Icon(
                        Icons.warning_rounded,
                        size: 32,
                        color: Color.fromRGBO(255, 0, 0, 1),
                      ),
                    ),
                    onTap: () {
                      makeRequest(
                          'https://icyindia.com/en/termsofuse', context);
                    },
                  ),
                  const Divider(),
                  GestureDetector(
                    child: const ListTile(
                      title: Text(
                        // "Feedback",
                        "Privacy Policy",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Signika',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      tileColor: Color.fromRGBO(255, 0, 0, 0.05),
                      trailing: Icon(
                        // Icons.feedback_rounded,
                        Icons.privacy_tip_rounded,
                        size: 31,
                        color: Color.fromRGBO(255, 0, 0, 1),
                      ),
                    ),
                    onTap: () {
                      makeRequest('https://icyindia.com/en/privacy', context);
                    },
                  ),
                  const Divider(),

                  // ListTile(
                  //   title: Text(
                  //     "LogOut",
                  //     style: TextStyle(
                  //       fontSize: 20,
                  //       fontFamily: 'Signika',
                  //       letterSpacing: 1,
                  //       fontWeight: FontWeight.w700,
                  //     ),
                  //   ),
                  //   tileColor: Color.fromRGBO(255, 0, 0, 0.05),
                  //   trailing: Icon(
                  //     Icons.logout,
                  //     size: 32,
                  //     color: Color.fromRGBO(255, 0, 0, 1),
                  //   ),
                  //   onTap: () {
                  //     debugPrint(Random().nextDouble());
                  //     showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return AlertDialog(
                  //           title: Text(
                  //             'Alert !!!',
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //               color: Color.fromRGBO(255, 0, 0, 1),
                  //               fontWeight: FontWeight.w700,
                  //               fontFamily: 'Signika',
                  //               fontSize: 24,
                  //             ),
                  //           ),
                  //           content: Text(
                  //             'Do you want to logout?',
                  //             textAlign: TextAlign.center,
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.w500,
                  //               fontFamily: 'Signika',
                  //               fontSize: 20,
                  //             ),
                  //           ),
                  //           backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                  //           actions: [
                  //             SizedBox(
                  //               width: double.maxFinite,
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                 children: [
                  //                   OutlinedButton(
                  //                     // borderSide: BorderSide(
                  //                     //   width: 1.5,
                  //                     //   color: Color.fromRGBO(255, 0, 0, 1),
                  //                     // ),
                  //                     child: Text(
                  //                       'No',
                  //                       style: TextStyle(
                  //                         color: Color.fromRGBO(255, 0, 0, 1),
                  //                         fontWeight: FontWeight.w500,
                  //                         fontFamily: 'Signika',
                  //                         fontSize: 18,
                  //                       ),
                  //                     ),
                  //                     onPressed: () {
                  //                       Navigator.of(context).pop();
                  //                     },
                  //                   ),
                  //                   OutlinedButton(
                  //                     // borderSide: BorderSide(
                  //                     //   width: 1.5,
                  //                     //   color: Color.fromRGBO(255, 0, 0, 1),
                  //                     // ),
                  //                     child: Text(
                  //                       'Yes',
                  //                       style: TextStyle(
                  //                         color: Color.fromRGBO(255, 0, 0, 1),
                  //                         fontWeight: FontWeight.w500,
                  //                         fontFamily: 'Signika',
                  //                         fontSize: 18,
                  //                       ),
                  //                     ),
                  //                     onPressed: () {
                  //                       Navigator.of(context).pop();
                  //                       // AuthService().signOut();
                  //                     },
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     );
                  //   },
                  // ),
                  // Divider(),
                ],
              ),
            ),
          ),
          Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            padding: const EdgeInsets.only(bottom: 65),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: const Color.fromRGBO(255, 0, 0, 1),
                      width: 1,
                    ),
                  ),
                  child: const ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.group_rounded,
                          color: Color.fromRGBO(36, 14, 123, 1),
                          size: 36,
                        ),
                        Text(
                          // "Feedback",
                          "Share App",
                          style: TextStyle(
                            color: Color.fromRGBO(36, 14, 123, 1),
                            fontSize: 20,
                            fontFamily: 'Signika',
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Icon(
                          // Icons.feedback_rounded,
                          Icons.share_rounded,
                          size: 31,
                          color: Color.fromRGBO(36, 14, 123, 1),
                        ),
                      ],
                    ),
                    // tileColor: Color.fromRGBO(255, 0, 0, 0.05),
                    // trailing: Icon(
                    //   // Icons.feedback_rounded,
                    //   Icons.share_rounded,
                    //   size: 31,
                    //   color: Color.fromRGBO(36, 14, 123, 1),
                    // ),
                  ),
                ),
                onTap: () {
                  Share.share(
                      "*WA Sticker*  -  Get it on Play Store\n\nExplore & share thousands of stickers for WhatsApp.\n\n😀 *Be a Pro WhatsApp User* 😀\n\nhttps://play.google.com/store/apps/details?id=com.icyindia.wasticker");
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        child: Image.asset(
                          "assets/twitter.jpg",
                          height: 45,
                          width: 45,
                        ),
                        onTap: () {
                          makeRequest(
                              "https://twitter.com/icyindiaOffice", context);
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Image.asset(
                          "assets/linkedin.png",
                          height: 45,
                          width: 45,
                        ),
                        onTap: () {
                          makeRequest(
                              "https://linkedin.com/company/icyindia", context);
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Image.asset(
                          "assets/instagram.png",
                          height: 45,
                          width: 45,
                        ),
                        onTap: () {
                          makeRequest(
                              "https://www.instagram.com/icyindiaoffice/",
                              context);
                        },
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        child: Image.asset(
                          "assets/facebook.png",
                          height: 45,
                          width: 45,
                        ),
                        onTap: () {
                          makeRequest("https://facebook.com/icyindia", context);
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  // This container is excluded to add gradient + splash ( with transparent background )
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(255, 255, 255, 1),
                        Color.fromRGBO(225, 255, 255, 1)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        height: 50,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              // "Feedback",
                              'Made with ❤ by IcyIndia  ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Signika',
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.double_arrow_rounded,
                              size: 16,
                              color: Color.fromRGBO(255, 0, 0, 0.5),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Future.delayed(const Duration(milliseconds: 125), () {
                          makeRequest(
                              'https://play.google.com/store/apps/dev?id=8405325976125486921',
                              context);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
