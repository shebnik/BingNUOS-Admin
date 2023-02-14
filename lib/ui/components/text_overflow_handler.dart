import 'package:flutter/material.dart';

class TextOverflowHandler extends StatelessWidget {
  final String text;
  final double maxWidth;
  final TextStyle style;

  const TextOverflowHandler({
    super.key,
    required this.text,
    required this.maxWidth,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: style,
      ),
      maxLines: 1,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: maxWidth,
    );

    if (textPainter.didExceedMaxLines) {
      int indexOfDesiredCharacter =
          textPainter.text!.toPlainText().indexOf("-");
      String firstLine = textPainter.text!
          .toPlainText()
          .substring(0, indexOfDesiredCharacter + 1);
      String secondLine = textPainter.text!
          .toPlainText()
          .substring(indexOfDesiredCharacter + 1);

      return RichText(
        text: TextSpan(
          text: firstLine,
          style: style,
          children: [
            const TextSpan(
              text: '\n',
            ),
            TextSpan(
              text: secondLine,
              style: style,
            ),
          ],
        ),
      );
    } else {
      return Text(
        text,
        style: style,
      );
    }
  }
}
