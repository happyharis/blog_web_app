import 'package:flutter/material.dart';

class BlogScaffold extends StatelessWidget {
  final List<Widget> children;
  final Widget floatingActionButton;
  final Widget appBar;
  final Widget body;

  const BlogScaffold({
    Key key,
    this.children,
    this.floatingActionButton,
    this.appBar,
    this.body,
  })  : assert(
          body == null || children == null,
          'Body and children cannot be together as they are both in the body of the scaffold',
        ),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar ?? AppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 612,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: body ??
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
