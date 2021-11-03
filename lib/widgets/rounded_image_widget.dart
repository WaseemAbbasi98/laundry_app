import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  final String imagePath;
  final Size size;
  final bool imgtype;

  const RoundedImage({
    this.imagePath =
        "https://w7.pngwing.com/pngs/639/452/png-transparent-computer-icons-avatar-user-profile-people-icon-child-face-heroes.png",
    this.size = const Size.fromWidth(120),
    this.imgtype = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Colors.black.withOpacity(0.8),
            offset: Offset(5.0, 6.0),
          ),
        ],
      ),
      child: ClipOval(
        child:
            // child: imgtype == false
            //     ? Image.asset(
            //         imagePath,
            //         width: size.width,
            //         height: size.width,
            //         fit: BoxFit.fitWidth,
            //       ):
            Image.network(
          imagePath,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.cumulativeBytesLoaded
                  : null,
            );
          },
          width: size.width,
          height: size.width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
