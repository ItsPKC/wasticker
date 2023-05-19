import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wasticker/stickers/stickerHome.dart';
import './services/ad_state.dart';
import 'navigation/homeButtonSet.dart';
import 'navigation/myDrawer.dart';
import './global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (myDeviceVersion == null) {
  //   setUpDetails();
  // }

  prefs = await SharedPreferences.getInstance();

  // Storage to Files&Media

  final initFuture = MobileAds.instance.initialize();
  await Firebase.initializeApp();
  final adState = AdState(initFuture);
  runApp(
    Provider.value(
      value: adState,
      builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WA Sticker',
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
      },
      // theme: ThemeData(
      // This is the theme of your application.
      //
      // TRY THIS: Try running your application with "flutter run". You'll see
      // the application has a blue toolbar. Then, without quitting the app,
      // try changing the seedColor in the colorScheme below to Colors.green
      // and then invoke "hot reload" (save your changes or press the "hot
      // reload" button in a Flutter-supported IDE, or press "r" if you used
      // the command line to start the app).
      //
      // Notice that the counter didn't reset back to zero; the application
      // state is not lost during the reload. To reset the state, use hot
      // restart instead.
      //
      // This works for code too, not just values: Most code changes can be
      // tested with just a hot reload.
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      // home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var myDrawerKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: myDrawerKey,
      drawer: const MyDrawer(),
      body: const StickerHome(),
      appBar: AppBar(
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //   statusBarColor: Color.fromRGBO(0, 0, 0, 1),
        // ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
        shadowColor: const Color.fromRGBO(255, 255, 255, 1),
        elevation: 2,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const FittedBox(
              child: Text(
                'WA Sticker',
                style: TextStyle(
                  fontSize: 22,
                  // color: Color.fromRGBO(35, 15, 123, 1),
                  color: Color.fromRGBO(0, 0, 255, 1),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  fontFamily: 'Signika',
                  // fontStyle: FontStyle.italic,
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  child: Image.asset(
                    'assets/logo_rounded.png',
                    width: 36,
                  ),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),

        // To create illusion for buttons
        leading: Button1(myDrawerKey),
      ),
    );
  }
}
