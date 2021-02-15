import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ChapterIconsOverlay extends StatelessWidget {
  final Widget child;
  final String codeLink;

  ChapterIconsOverlay({
    this.child,
    this.codeLink,
  });

  @override
  Widget build(_) {
    if (codeLink != null) {
      return Stack(
        children: [
          Positioned.fill(child: child),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              child: Icon(Icons.code),
              onTap: () => _launchURL(codeLink),
            ),
          ),
        ],
      );
    }

    return child;
  }

  Future<void> _launchURL(String url) async {
    if (await url_launcher.canLaunch(url)) {
      await url_launcher.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
