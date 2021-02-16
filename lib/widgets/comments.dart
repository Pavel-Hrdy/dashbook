import 'dart:io';

import 'package:dashbook/dashbook.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class Comments extends StatefulWidget {
  final Chapter currentChapter;

  const Comments({Key key, this.currentChapter}) : super(key: key);
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  String _markdownString;
  bool _isLoading = true;
  @override
  void initState() {
    initString();

    super.initState();
  }

  void initString() async {
    var stringFuture = rootBundle.loadString(
        'assets/comments/${widget.currentChapter.story.name}_${widget.currentChapter.name}.md');

    stringFuture.then((value) {
      setState(() {
        _markdownString = value;
        _isLoading = false;
      });
    }, onError: (_) {
      setState(() {
        _markdownString = null;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return _markdownString != null
        ? Markdown(data: _markdownString)
        : Center(
            child: Text(
              'Comment for this component was not found.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          );
  }
}
