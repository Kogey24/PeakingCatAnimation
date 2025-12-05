import 'package:flutter/material.dart';
import '../widgets/cat.dart';

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
      duration: Duration(seconds: 2),
      vsync: this,
    );

    catController.forward();

    catAnimation = Tween<double>(
      begin: 0.0,
      end: 100.0,
    ).animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Animation')),
      body: buildAnimation(),
    );
  }

  //helper method for building the animation
  Widget buildAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.only(top: catAnimation.value),
          child: child,
        );
      },
      child: Cat(),
    );
  }

  @override
  void dispose() {
    catController.dispose();
    super.dispose();
  }
}
