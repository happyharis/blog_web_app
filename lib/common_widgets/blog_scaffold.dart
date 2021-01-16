import 'package:flutter/material.dart';

class BlogScaffold extends StatelessWidget {
  final List<Widget> children;
  final Widget floatingActionButton;
  final Widget appBar;
  final bool isScrollable;
  final Widget body;

  const BlogScaffold({
    Key key,
    this.children,
    this.floatingActionButton,
    this.appBar,
    this.isScrollable = false,
    this.body,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var columnWidget = isScrollable
        ? SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children ?? [],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children ?? [],
          );
    return Scaffold(
      appBar: appBar ?? AppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 612,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: body ?? columnWidget,
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
