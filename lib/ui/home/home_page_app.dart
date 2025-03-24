import 'package:flutter/material.dart';
import 'package:flutter_meu_bnz/ui/home/home.dart';

class HomePageApp extends StatelessWidget {
  const HomePageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF35478E),
        toolbarHeight: 0,
      ),
      body: Home(),
      floatingActionButton: FloatingActionButton(
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => DescontosPage()),
                    // );
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
                value: 1,
                child: GestureDetector(
                  onTap: () {
                    print('Perfil');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => PerfilPage()),
                    // );
                  },
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('Perfil'),
                    ],
                  ),
                ),
              ),
            ],
            elevation: 8.0,
          );
        },
      ),

    );
  }
}

void main() => runApp(MaterialApp(home: HomePageApp()));
