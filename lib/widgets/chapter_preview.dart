import 'package:flutter/widgets.dart';

import '../dashbook.dart';
import 'chapter_icons_overlay.dart';

class ChapterPreview extends StatelessWidget {
  final Chapter currentChapter;

  ChapterPreview({this.currentChapter, Key key}) : super(key: key);

  @override
  Widget build(BuildContext ctx) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final child = currentChapter.widget(constraints);

        return ChapterIconsOverlay(
          child: child,
          codeLink: currentChapter.codeLink,
        );
      },
    );
  }
}
