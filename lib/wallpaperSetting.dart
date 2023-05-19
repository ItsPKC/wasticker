import 'package:flutter/material.dart';
import 'package:wasticker/global.dart';

class WallPaperSetting extends StatefulWidget {
  final Function manageColor;
  const WallPaperSetting(this.manageColor, {super.key});

  @override
  State<WallPaperSetting> createState() => _WallPaperSettingState();
}

class _WallPaperSettingState extends State<WallPaperSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: GridView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: chatWallpaper.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          // childAspectRatio: (MediaQuery.of(context).size.width - 15) /
          //     (MediaQuery.of(context).size.height - 15),s
          childAspectRatio: 9 / 16,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              Navigator.pop(context);
              chatWallpaperNumber = index;
              await prefs.setInt('chatWallpaperNumber', index);
              widget.manageColor(index);
            },
            child: Container(
              color: chatWallpaper[index]['wallpaper'] as Color,
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: index == chatWallpaperNumber
                  ? const CircleAvatar(
                      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                      child: Icon(
                        Icons.done_all_rounded,
                        color: Color.fromRGBO(230, 0, 0, 1),
                      ),
                    )
                  : Container(),
            ),
          );
        },
      ),
    );
  }
}
