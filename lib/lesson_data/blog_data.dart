import 'package:ielts/models/blog.dart';

List getBlogData() {
  return [
    Blog(
        title: 'Why the freelance life may get easier and this is more longer',
        imageUrl:
            'https://kinsta.com/wp-content/uploads/2018/05/best-tools-for-freelancers-1-1.png',
        time: DateTime.now(),
        tags: ["Entrepreneur", "Freelance"]),
    Blog(
        title: 'Why the freelance life may get easier',
        imageUrl:
            'https://insights.dice.com/wp-content/uploads/2019/04/Billing-Clients-Freelance-Developer-Freelancers-Dice.png',
        time: DateTime.now(),
        tags: ["Entrepreneur", "Freelance"]),
  ];
}
