import 'package:flutter/material.dart';

class BottomAppBarWidget extends StatelessWidget {
  final Function() onTap;
  const BottomAppBarWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Text(
                    'Подтвердить',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
