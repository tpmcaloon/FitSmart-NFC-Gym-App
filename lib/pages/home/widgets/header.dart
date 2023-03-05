import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final displayName = user?.email?.substring(0, user.email?.indexOf('@')) ?? "No Username";
    // final photoUrl = FirebaseAuth.instance.currentUser?.photoURL;
    return SizedBox(
      width: double.infinity,
      height: 185,
      child: Stack(
        children: [
          CustomPaint(
            painter: HeaderPainter(),
            size: const Size(double.infinity, 200)
            ),
            Positioned(
              top: 20,
              left: 20,
              child: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Color.fromRGBO(30, 215, 96, 1,)
              ),
            ),
          ),
          const Positioned(
            top: 35,
            right: 25,
            child: CircleAvatar(
              minRadius: 25,
              maxRadius: 25,
              foregroundImage: AssetImage('assets/profilePic.jpg'),
            ),
          ),
          Positioned(
            left: 33,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello,',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 20
                  ),
                ),
                Text(
                  displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 26
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    
    Paint backGColor = Paint()..color = const Color.fromRGBO(25, 20, 20, 1);
    Paint waveColor = Paint()..color = const Color.fromRGBO(30, 215, 96, 0.8);
    
    canvas.drawRect(Rect.fromPoints(const Offset(0,0), Offset(size.width, size.height)), backGColor);
    
    var path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.4, size.width * 0.5, size.height * 0.6);
    path.quadraticBezierTo(size.width * 0.8, size.height, size.width * 1.0, size.height * 0.6);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    canvas.drawPath(path, waveColor);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}