import 'package:flutter/material.dart';
import 'badge.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.only(top: 20),
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15),
                  height: 40,
                  child: Image.asset(
                    "assets/images/bdlogo.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Badge(
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_bag_sharp,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {},
                    ),
                    value: "7", //int

                    color: Colors.pinkAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
