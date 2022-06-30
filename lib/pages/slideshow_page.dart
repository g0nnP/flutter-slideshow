import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/slideshow.dart';

class SlideshowPage extends StatelessWidget {
  const SlideshowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideShow(
        slides: [
          SvgPicture.asset('assets/svgs/slide_1.svg'),
          SvgPicture.asset('assets/svgs/slide_2.svg'),
          SvgPicture.asset('assets/svgs/slide_3.svg'),
          SvgPicture.asset('assets/svgs/slide_4.svg'),
          SvgPicture.asset('assets/svgs/slide_5.svg'),
        ],
        upDots: true,
        activeBulletColor: const Color.fromRGBO(0, 191, 166, 1),
        activeBullet: 20,
      )
    );
  }
}