import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 177,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: const Color(0xFF083DCC)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF083DCC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Aproveite!',
                      style: TextStyle(
                        color: Color(0xFFFFF6FC),
                        fontFamily: 'RobotoMono',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xF71F2E8D),
                    fontFamily: 'RobotoCondensed',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  price,
                  style: const TextStyle(
                    color: Color(0xFF35478E),
                    fontFamily: 'RobotoFlex',
                    fontSize: 28,
                    fontWeight: FontWeight.w900,

                  ),
                ),
                const Text(
                  'CADA',
                  style: TextStyle(
                    color: Color(0xF71F2E8D),
                    fontFamily: 'RobotoCondensed',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}