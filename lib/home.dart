
import 'package:boko_test/Components/menu-item.dart';
import 'package:boko_test/utils/color.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const Radius radius = Radius.circular(50);
  final String user_name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/logo.png', height: 100),
            Wrap(
              children: [
                const Text('Hello ',
                    style: TextStyle(fontSize: 18, color: redColor)),
                Text(user_name,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: redColor)),
              ],
            )
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: grayColor,
            borderRadius: BorderRadius.only(topLeft: radius, topRight: radius)),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Menu ',
                      style: TextStyle(fontSize: 18, color: gray2Color)),
                  Icon(
                    Icons.cancel,
                    color: gray2Color,
                  )
                  // Image.asset('assets/cancel.png', height: 20),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  MenuItem(
                      icon: 'user-icon.png',
                      text: 'Username',
                      subtitle: 'Profile and preferences'),
                  MenuItem(
                      icon: 'verify-icon.png',
                      text: 'Identity verification',
                      subtitle: 'Verified',
                      verified: true),
                  MenuItem(
                      icon: 'paiement-icon.png',
                      text: 'Payment methods',
                      subtitle: ''),
                  MenuItem(
                      icon: 'security-icon.png',
                      text: 'Account Security',
                      subtitle: ''),
                  MenuItem(
                      icon: 'logout-icon.png', text: 'Logout', subtitle: ''),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Terms and conditions ',
                    style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: blueColor)),
                Text('Privacy policy ',
                    style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: blueColor)),
                Text('v 1.0.0 ',
                    style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: gray2Color)),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

// class BottomNavBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: [
//         const BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//               color: redColor,
//             ),
//             label: ''),
//         const BottomNavigationBarItem(
//             icon: Icon(
//               Icons.notifications_none_outlined,
//               color: redColor,
//             ),
//             label: ''),
//         BottomNavigationBarItem(
//             icon: Image.asset(
//               'assets/menu-icon.png',
//               height: 40,
//             ),
//             label: ''),
//         BottomNavigationBarItem(
//             icon: Image.asset(
//               'assets/person-icon.png',
//               height: 20,
//             ),
//             label: ''),
//         const BottomNavigationBarItem(
//             icon: Icon(
//               Icons.menu,
//               color: gray2Color,
//             ),
//             label: ''),
//       ],
//     );
//   }
// }
class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // Permet à l'élément de déborder
      children: [
        BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: redColor,
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications_none_outlined,
                color: redColor,
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: SizedBox(), // On remplace par une SizedBox vide ici
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/person-icon.png',
                height: 20,
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
                color: gray2Color,
              ),
              label: '',
            ),
          ],
        ),
        Positioned(
          top:
              -25, // Modifie la position verticale (négatif pour faire déborder)
          left: MediaQuery.of(context).size.width / 2 - 20, // Centrer l'icône
          child: Image.asset(
            'assets/menu-icon.png',
            height: 70,
          ),
        ),
      ],
    );
  }
}
