import 'package:flutter/material.dart';
import 'package:ielts/screens/onboarding/widgets/text_column.dart';

class EducationTextColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextColumn(
      title: 'Mentor Help and Reviews',
      text:
          'Get help directly from mentors and clarify doubts. Also get reviews on your essays',
    );
  }
}
