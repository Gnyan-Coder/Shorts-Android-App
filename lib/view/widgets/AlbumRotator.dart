import 'package:flutter/material.dart';

class AlbumRotator extends StatefulWidget {
  final String profilePicUrl;
  const AlbumRotator({Key? key, required this.profilePicUrl}) : super(key: key);

  @override
  State<AlbumRotator> createState() => _AlbumRotatorState();
  }

class _AlbumRotatorState extends State<AlbumRotator> with SingleTickerProviderStateMixin{
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller=AnimationController(vsync: this,duration: const Duration(seconds: 5));
    controller.forward();
    controller.repeat();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0,end: 1.0).animate(controller),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.grey,
                  Colors.white,
                ]),
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image(
                  image: NetworkImage(widget.profilePicUrl),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
