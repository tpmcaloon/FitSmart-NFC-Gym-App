import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  final AppBar appBar;
  
  const MainAppBar({
    Key? key,
    required this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(25, 20, 20, 1),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 16,
        ),
      ),
      title: const Text('Tracker',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        )
      ),
      centerTitle: true,
      actions: [
        TextButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(5),
            minimumSize: const Size(30, 30),
            maximumSize: const Size(30, 30),
            foregroundColor: const Color.fromRGBO(30, 215, 96, 1), 
            backgroundColor: const Color.fromRGBO(30, 215, 96, 0.25), 
            shape: const CircleBorder()
          ), 
          child: const Icon(
            Icons.notifications,
            size: 16,
          ),
        )
      ],
    );
  }
  
  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}