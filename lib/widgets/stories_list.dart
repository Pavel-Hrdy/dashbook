import 'package:dashbook/widgets/link.dart';
import 'package:flutter/widgets.dart';

import '../dashbook.dart';

class StoriesList extends StatelessWidget {
  final List<Story> stories;
  final Chapter selectedChapter;
  final OnSelectChapter onSelectChapter;

  StoriesList({this.stories, this.selectedChapter, this.onSelectChapter});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      SizedBox(height: 5),
      Text(
        'Stories',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
      SizedBox(height: 10),
    ];

    stories.forEach((story) {
      children.add(
        Text(
          story.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
      children.add(SizedBox(height: 10));

      story.chapters.forEach((chapter) {
        children.add(
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Link(
              label: "  ${chapter.name}",
              textAlign: TextAlign.left,
              padding: EdgeInsets.zero,
              height: 20,
              textStyle: TextStyle(
                fontWeight: chapter.id == selectedChapter.id
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            onTap: () {
              onSelectChapter(chapter);
            },
          ),
        );
      });
    });

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}
