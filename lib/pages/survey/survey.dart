import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SurveyPage extends StatelessWidget {
  const SurveyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Survey')),
      body: Html(data: '''<div data-tf-widget="r2dJh7Qx" data-tf-opacity="100" data-tf-iframe-props="title=FitSmart Feedback Survey Template" data-tf-transitive-search-params data-tf-medium="snippet" style="width:100%;height:500px;"></div><script src="//embed.typeform.com/next/embed.js"></script>''')
    );
  }
}