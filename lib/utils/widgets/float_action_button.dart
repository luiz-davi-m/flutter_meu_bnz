import 'package:flutter/material.dart';

import '../../ui/home/home.dart';
import '../../ui/perfil/perfil_page.dart';

class MenuFloatingActionButton extends StatelessWidget {
  const MenuFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      child: Icon(Icons.menu, color: Colors.white),
      onPressed: () {
        final RenderBox button = context.findRenderObject() as RenderBox;
        final Offset buttonPosition = button.localToGlobal(Offset.zero);
        final double buttonHeight = button.size.height;
        final double buttonWidth = button.size.width;

        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            buttonPosition.dx + buttonWidth - 50,
            buttonPosition.dy + buttonHeight - 233,
            0.0,
            0.0,
          ),
          items: [
            PopupMenuItem(
              value: 1,
              child: GestureDetector(
                onTap: () {
                  print('Descontos');
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.discount, color: Colors.blue),
                    SizedBox(width: 10),
                    Text('Descontos'),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: GestureDetector(
                onTap: () {
                  print('Jornal');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => JornalPage()),
                  // );
                },
                child: Row(
                  children: [
                    Icon(Icons.newspaper, color: Colors.blue),
                    SizedBox(width: 10),
                    Text('Jornal'),
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              value: 3,
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.blue),
                  SizedBox(width: 10),
                  Text('Perfil'),
                ],
              ),
              onTap: () {
                Future.delayed(Duration.zero, () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PerfilPage()),
                  );
                });
              },
            ),
          ],
          elevation: 8.0,
        );
      },
    );
  }
}
