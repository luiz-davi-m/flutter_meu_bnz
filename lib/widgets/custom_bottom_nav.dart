import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 274,
      height: 55,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            offset: Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.local_offer_outlined,
            label: 'Descontos',
            color: const Color(0xFFB3B3B3),
          ),
          _buildNavItem(
            icon: Icons.book_outlined,
            label: 'Jornal',
            color: const Color(0xFF35478E),
            isSelected: true,
          ),
          _buildNavItem(
            icon: Icons.person_outline,
            label: 'Conta',
            color: const Color(0xFF8C8C8C),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required Color color,
    bool isSelected = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 9,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}