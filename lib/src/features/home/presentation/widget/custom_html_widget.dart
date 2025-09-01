import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../../../utilities/utilities.dart';

class CustomHtmlWidget extends StatelessWidget {
  const CustomHtmlWidget({super.key, required this.htmlString});
  final String htmlString;
  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      htmlString,
      textStyle: AppStyles.getRegularTextStyle(fontSize: 14, color: AppColors.textColor),
      customStylesBuilder: (element) {
        if (element.localName == 'h2') {
          return {
            'font-size': '24px', // font size
            'font-weight': '600', // bold text
            'margin': '0', // remove default margins
            'color': 'black',
            'line-height': '28px',
          };
        }
        if (element.localName == 'h3') {
          return {
            'font-size': '21px', // font size
            'font-weight': '500', // bold text
            'margin': '0', // remove default margins
            'color': 'black',
            'line-height': '25px',
          };
        }
        return null; // keep default for other tags
      },
    );
  }
}
