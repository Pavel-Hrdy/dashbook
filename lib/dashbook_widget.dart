import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'dashbook.dart';

typedef OnSelectChapter = Function(Chapter chapter);
typedef OnPropertyChange = void Function();

enum CurrentView {
  STORIES,
  CHAPTER,
  PROPERTIES,
}

class Dashbook extends StatelessWidget {
  final List<Story> stories = [];
  final ThemeData theme;

  Dashbook({this.theme});

  Story storiesOf(String name) {
    final story = Story(name);
    stories.add(story);

    return story;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      routes: {
        '/': (BuildContext context) {
          bool isLargeScreen = MediaQuery.of(context).size.width > 768;
          return Scaffold(
            body: SafeArea(
              child: isLargeScreen
                  ? DashbookBodyWeb(stories: stories)
                  : DashbookBodyMobile(
                      stories: stories,
                    ),
            ),
          );
        },
      },
    );
  }
}
