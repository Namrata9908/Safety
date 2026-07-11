import 'dart:async';
import 'package:flutter/material.dart';

class SosButton extends StatefulWidget {
  final Future<void> Function() onPressed;

  const SosButton({super.key, required this.onPressed});

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int countdown = 0;
  bool isCounting = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> startCountdown() async {
    if (isCounting) return;

    setState(() {
      isCounting = true;
      countdown = 3;
    });

    for (int i = 3; i > 0; i--) {
      setState(() {
        countdown = i;
      });

      await Future.delayed(const Duration(seconds: 1));
    }

    setState(() {
      isCounting = false;
      countdown = 0;
    });

    await widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,

      child: GestureDetector(
        onTap: startCountdown,

        child: Container(
          height: 170,

          width: 170,

          decoration: BoxDecoration(
            shape: BoxShape.circle,

            color: Colors.red,

            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.45),

                blurRadius: 30,

                spreadRadius: 8,
              ),
            ],
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(
                isCounting ? Icons.timer : Icons.warning,

                color: Colors.white,

                size: 45,
              ),

              const SizedBox(height: 8),

              Text(
                isCounting ? "$countdown" : "SOS",

                style: const TextStyle(
                  color: Colors.white,

                  fontSize: 32,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                isCounting ? "Sending..." : "Tap for Help",

                style: const TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
