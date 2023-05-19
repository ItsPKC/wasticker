import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateApp extends StatefulWidget {
  final String _date, _appLink, _notice;

  const UpdateApp(this._date, this._appLink, this._notice, {super.key});

  @override
  State<UpdateApp> createState() => _UpdateAppState();
}

class _UpdateAppState extends State<UpdateApp> {
  Future<void> _makeRequestOutSide(url) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      try {
        // ignore: deprecated_member_use
        if (await canLaunch(url)) {
          // ignore: deprecated_member_use
          await launch(url);
        } else {
          debugPrint('Can\'t lauch now !!!');
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'WA Sticker',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    letterSpacing: 1,
                    color: Color.fromRGBO(255, 0, 0, 1),
                  ),
                ),
                content: const Text(
                  'Failed to connect ...',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1,
                    color: Color.fromRGBO(36, 14, 123, 1),
                  ),
                ),
                actions: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 0, 0, 1),
                        border: Border.all(
                          color: const Color.fromRGBO(255, 0, 0, 1),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        'Close',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Signika',
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                          letterSpacing: 2,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
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
            // title: Text('WA Sticker'),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: const Icon(
                    Icons.network_check,
                    size: 32,
                    color: Color.fromRGBO(255, 0, 0, 1),
                  ),
                ),
                const Text(
                  'No Internet',
                  style: TextStyle(
                    fontFamily: 'Signika',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    letterSpacing: 1,
                    color: Color.fromRGBO(36, 14, 123, 1),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              GestureDetector(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 0, 0, 1),
                    border: Border.all(
                      color: const Color.fromRGBO(255, 0, 0, 1),
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    'Close',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Signika',
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      letterSpacing: 2,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  var initialTimer = 5;

  reduceTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        initialTimer -= 1;
      });
      if (initialTimer > 0) {
        reduceTimer();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    reduceTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.5,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.2,
                  child: Image.asset('assets/logo_rounded.png'),
                ),
              ),
              Expanded(
                flex: 3,
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          'Update Available !!!',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(255, 0, 0, 1),
                          ),
                        ),
                        FittedBox(
                          child: Text(
                            'Updated on  :  ${widget._date}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 25,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            // '** Pankaj Kumar\n** I am from buxar.',
                            widget._notice,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Signika',
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
                        ),
                        onPressed: () {
                          if (initialTimer == 0) {
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          (initialTimer > 0) ? '$initialTimer' : 'Not Now',
                          style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Signika',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
                        ),
                        onPressed: () async {
                          // var url = isDevVersion
                          //     ? widget._appLinkPro
                          //     : widget._appLink;
                          _makeRequestOutSide(widget._appLink);
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                            fontFamily: 'Signika',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
