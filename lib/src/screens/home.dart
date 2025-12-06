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
  late Animation<double> boxAnimation;
  late AnimationController boxController;

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

    //boxanimation
    boxController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    boxAnimation = Tween<double>(
      begin: pi * .6,
      end: pi * .65,
    ).animate(CurvedAnimation(parent: boxController, curve: Curves.linear));

    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
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
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(height: 10, width: 125.0, color: Colors.brown),
        builder: (context, child) {
          return Transform.rotate(
            angle: boxAnimation.value,
            alignment: Alignment.topLeft,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    catController.dispose();
    boxController.dispose();
    super.dispose();
  }
}
