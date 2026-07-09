import 'package:flutter/material.dart';

class SosButton extends StatefulWidget {
  final VoidCallback onPressed;

  const SosButton({super.key, required this.onPressed});

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

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

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,

      child: GestureDetector(
        onTap: widget.onPressed,

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

          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(Icons.warning, color: Colors.white, size: 45),

              SizedBox(height: 8),

              Text(
                "SOS",

                style: TextStyle(
                  color: Colors.white,

                  fontSize: 32,

                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 5),

              Text(
                "Tap for Help",

                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
