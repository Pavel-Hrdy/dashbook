import 'package:flutter/material.dart';

import 'dashbook.dart';
import 'widgets/index.dart';

class DashbookBodyWeb extends StatefulWidget {
  final List<Story> stories;

  DashbookBodyWeb({this.stories});

  @override
  State createState() => _DashbookBodyWebState();
}

class _DashbookBodyWebState extends State<DashbookBodyWeb> {
  Chapter _currentChapter;
  bool _isStoriesOpen = false;

  @override
  void initState() {
    super.initState();

    if (widget.stories.isNotEmpty) {
      final story = widget.stories.first;

      if (story.chapters.isNotEmpty) {
        _currentChapter = story.chapters.first;
      }
    }
  }

  bool _hasProperties() => _currentChapter.ctx.properties.isNotEmpty;

  void _toggleStoriesList() {
    setState(() {
      _isStoriesOpen = !_isStoriesOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        Widget body;
        final chapterWidget = _currentChapter?.widget(constraints);
        final preview = ChapterIconsOverlay(
          child: chapterWidget,
          codeLink: _currentChapter.codeLink,
        );

        if (_hasProperties()) {
          body = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 10,
                child: preview,
              ),
              Expanded(
                flex: 4,
                child: !_hasProperties()
                    ? Container()
                    : Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                                color: Theme.of(context).dividerColor),
                          ),
                        ),
                        child: PropertiesContainer(
                          currentChapter: _currentChapter,
                          onPropertyChange: () {
                            setState(() {});
                          },
                        ),
                      ),
              ),
            ],
          );
        } else {
          body = preview;
        }

        final storiesWidget = StoriesList(
          stories: widget.stories,
          selectedChapter: _currentChapter,
          onSelectChapter: (chapter) {
            setState(() {
              _currentChapter = chapter;
            });
          },
        );

        final _storiesStackList = <Widget>[];

        if (_isStoriesOpen) {
          _storiesStackList.add(
            Positioned.fill(child: storiesWidget),
          );
        }

        _storiesStackList.add(
          Positioned(
            top: 5,
            right: 10,
            child: GestureDetector(
              child: Icon(
                _isStoriesOpen ? Icons.navigate_before : Icons.navigate_next,
              ),
              onTap: _toggleStoriesList,
            ),
          ),
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: _isStoriesOpen ? 2 : null,
              child: Container(
                width: _isStoriesOpen ? null : 45,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(color: Theme.of(context).dividerColor),
                  ),
                ),
                child: Stack(children: _storiesStackList),
              ),
            ),
            Expanded(
              flex: 8,
              child: body,
            ),
          ],
        );
      },
    );
  }
}
