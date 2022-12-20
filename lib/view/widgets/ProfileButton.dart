import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String profilePhotoUrl;
  const ProfileButton({Key? key,required this.profilePhotoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
              child: Container(
            width: 50,
            height: 50,
            padding: const EdgeInsets.all(1.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.0)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhotoUrl),
                fit: BoxFit.cover,
              ),
            ),
          ))
        ],
      ),
    );
  }
}
