import 'package:flutter/material.dart';
import '../widgets/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late AnimationController catController;

  @override
  void initState() {
    super.initState();
    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    catAnimation = Tween<double>(
      begin: -35.0,
      end: -80.0,
    ).animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation')),
      body: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [buildCatAnimation(), buildBox(), buildLeftFlap()],
          ),
        ),
      ),
    );
  }

  //helper method for building the animation
  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
          child: child!,
        );
      },
      child: Cat(),
    );
  }

  void onTap() {
    if (catController.status != AnimationStatus.completed) {
      catController.forward();
    }
    catController.reverse();
  }

  Widget buildBox() {
    return Container(width: 200, height: 200, color: Colors.brown);
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: Transform.rotate(
        angle: pi / 0.6,
        alignment: Alignment.topLeft,
        child: Container(height: 10, width: 125.0, color: Colors.brown),
      ),
    );
  }

  @override
  void dispose() {
    catController.dispose();
    super.dispose();
  }
}
