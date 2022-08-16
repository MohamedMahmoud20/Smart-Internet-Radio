import 'package:flutter/material.dart';
import 'category/News.dart';
import 'category/Quraan.dart';
import 'category/Sports.dart';
import 'category/music.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  _HeaderState createState() => _HeaderState();
}
class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'lib/images/appbar.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Image(
            image: AssetImage('lib/images/logo.png'),
            width: 150,
            height: 150,
          ),
        ],
      ),
    );
  }
}

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          buildItem(
              name: 'Music',
              icon: Icons.music_note,
              onClicked: () => category(context, 1)),
          buildItem(
              name: 'Sports',
              icon: Icons.sports_basketball,
              onClicked: () => category(context, 2)),
          buildItem(
              name: 'Quraan',
              icon: Icons.book_online_sharp,
              onClicked: () => category(context, 3)),
          buildItem(
              name: 'News',
              icon: Icons.web_outlined,
              onClicked: () => category(context, 4)),
        ],
      ),
    );
  }
}

Widget buildItem({
  required String name,
  required IconData icon,
  required VoidCallback onClicked,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      height: 50,
      child: InkWell(
        onTap: onClicked,
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void category(BuildContext context, int index) {
  Navigator.pop(context);
  switch (index) {
    case 1:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Music()));
      break;
    case 2:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => sports()));
      break;
    case 3:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Quraan()));
      break;
    case 4:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => News()));
      break;
  }
}
