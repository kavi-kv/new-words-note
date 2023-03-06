import 'package:flutter/material.dart';
import '../Screens/home.dart';

class MyDrawer extends Drawer {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: key,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DrawerHeader(),
              const SizedBox(
                height: 16.0,
              ),
              DrawerNavigationItem(
                iconData: Icons.home_filled,
                title: "Home",
                onTap: () {},
                selected: true,
              ),
              DrawerNavigationItem(
                iconData: Icons.favorite,
                title: "Favourites",
                onTap: () {},
                selected: false,
              ),
              DrawerNavigationItem(
                iconData: Icons.chat_outlined,
                title: "Chat",
                onTap: () {},
                selected: false,
              ),
              DrawerNavigationItem(
                iconData: Icons.settings,
                title: "Setting",
                onTap: () {},
                selected: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//?: Drawer Navigation items
class DrawerNavigationItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final bool selected;
  final Function() onTap;
  const DrawerNavigationItem(
      {super.key,
      required this.iconData,
      required this.title,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      leading: Icon(iconData),
      onTap: onTap,
      title: Text(title),
      selectedTileColor: Colors.blueAccent.shade100,
      selected: selected,
      selectedColor: Colors.black87,
    );
  }
}

//?: Drawer Header
class DrawerHeader extends StatelessWidget {
  const DrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 35,
          backgroundImage: AssetImage(isIconDarkState
              ? "images/Light_Logo-removebg.png"
              : "images/Dark_Logo-removebg.png"),
        ),
        const SizedBox(
          width: 10.0,
        ),
        const Text(
          "Bew Words",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
