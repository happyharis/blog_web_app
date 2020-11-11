import 'package:blog_web_app/constrained_centre.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: 612,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedCentre(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://i.ibb.co/ZKkSW4H/profile-image.png'),
                  radius: 72,
                ),
              ),
              SizedBox(height: 18),
              ConstrainedCentre(
                child: SelectableText(
                  'Flutter Dev',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              SizedBox(height: 40),
              SelectableText(
                'Hello, I’m a human. I’m a Flutter developer and an avid human. Occasionally, I nap.',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(height: 40),
              SelectableText(
                'Blog',
                style: Theme.of(context).textTheme.headline2,
              ),
              BlogListTile()
            ],
          ),
        ),
      ),
    );
  }
}

class BlogListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = Provider.of<String>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        InkWell(
          child: Text(
            title,
            style: TextStyle(color: Colors.blueAccent.shade700),
          ),
          onTap: () {},
        ),
        SizedBox(height: 10),
        SelectableText(
          'January 2, 2020',
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    );
  }
}
