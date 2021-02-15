import 'package:dashbook/widgets/index.dart';
import 'package:flutter/widgets.dart';

import 'dashbook.dart';

class DashbookBodyMobile extends StatefulWidget {
  final List<Story> stories;

  DashbookBodyMobile({this.stories});

  @override
  State createState() => _DashbookBodyMobileState();
}

class _DashbookBodyMobileState extends State<DashbookBodyMobile> {
  CurrentView _currentView;
  Chapter _currentChapter;

  @override
  void initState() {
    super.initState();

    if (widget.stories.isNotEmpty) {
      final story = widget.stories.first;
      _currentView = CurrentView.STORIES;

      if (story.chapters.isNotEmpty) {
        _currentChapter = story.chapters.first;
        _currentView = CurrentView.CHAPTER;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget view;
    if (_currentView == CurrentView.CHAPTER) {
      view = _currentChapter != null
          ? ChapterPreview(
              currentChapter: _currentChapter,
              key: Key(_currentChapter.id),
            )
          : null;
    } else if (_currentView == CurrentView.STORIES) {
      view = StoriesList(
        stories: widget.stories,
        selectedChapter: _currentChapter,
        onSelectChapter: (chapter) {
          setState(() {
            _currentChapter = chapter;
            _currentView = CurrentView.CHAPTER;
          });
        },
      );
    } else {
      view = PropertiesContainer(currentChapter: _currentChapter);
    }

    return Column(children: [
      Expanded(child: view),
      Container(
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: Link(
                label: 'Stories',
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontWeight: _currentView == CurrentView.STORIES
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
                onTap: () {
                  setState(() {
                    _currentView = CurrentView.STORIES;
                  });
                },
              ),
            ),
            Expanded(
              child: Link(
                label: 'Preview',
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontWeight: _currentView == CurrentView.CHAPTER
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
                onTap: () {
                  setState(() {
                    _currentView = CurrentView.CHAPTER;
                  });
                },
              ),
            ),
            Expanded(
              child: Link(
                label: 'Properties',
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontWeight: _currentView == CurrentView.PROPERTIES
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
                onTap: () {
                  setState(() {
                    _currentView = CurrentView.PROPERTIES;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
