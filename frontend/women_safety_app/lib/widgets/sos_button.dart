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

  bool isCounting = false;
  int countdown = 3;

  Timer? timer;

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
    timer?.cancel();

    _controller.dispose();

    super.dispose();
  }

  void startCountdown() {
    setState(() {
      isCounting = true;

      countdown = 3;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (countdown == 1) {
        timer.cancel();

        setState(() {
          isCounting = false;
        });

        await widget.onPressed();
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  void cancelSOS() {
    timer?.cancel();

    setState(() {
      isCounting = false;

      countdown = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScaleTransition(
          scale: _animation,

          child: GestureDetector(
            onTap: isCounting ? null : startCountdown,

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

              child: Center(
                child: isCounting
                    ? Text(
                        "$countdown",

                        style: const TextStyle(
                          color: Colors.white,

                          fontSize: 50,

                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Column(
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
          ),
        ),

        const SizedBox(height: 20),

        if (isCounting)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,

              foregroundColor: Colors.white,
            ),

            onPressed: cancelSOS,

            child: const Text("Cancel SOS", style: TextStyle(fontSize: 18)),
          ),
      ],
    );
  }
}
git 