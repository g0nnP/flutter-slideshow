import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:slideshow_example/models/slider_model.dart';

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SliderModel(),
      child: Scaffold(
        body: Center(
          child: Column(
            children: const [
              Expanded(child: _Slides()),
              _Dots()
            ],
          )
        ),
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides({Key? key}) : super(key: key);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {

  late PageController pViewController;

  @override
  void initState() {
    pViewController = PageController();
    pViewController.addListener(() {
      Provider.of<SliderModel>(context, listen: false).setCurrentPage
        = pViewController.page;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: PageView(
        controller: pViewController,
        children: const [
          _Slide('assets/svgs/slide_1.svg'),
          _Slide('assets/svgs/slide_2.svg'),
          _Slide('assets/svgs/slide_3.svg'),
        ]
      ),
    );
  }

  @override
  void dispose() {
    pViewController.dispose();
    super.dispose();
  }
}

class _Slide extends StatelessWidget {

  final String svgAsset;

  const _Slide(this.svgAsset);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: SvgPicture.asset(svgAsset),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          _Dot(0),
          _Dot(1),
          _Dot(2),
        ],
      )
    );
  }
}

class _Dot extends StatelessWidget {

  final int index;

  const _Dot(this.index,{
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<SliderModel>(context);
    return AnimatedContainer(
      width: (p.getCurrentPage! >= index - 0.5 && p.getCurrentPage! < index + 0.5)
      ? 20
      : 12,
      height: (p.getCurrentPage! >= index - 0.5 && p.getCurrentPage! < index + 0.5)
      ? 20
      :12,
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: (p.getCurrentPage! >= index - 0.5 && p.getCurrentPage! < index + 0.5)
        ? const Color.fromRGBO(0, 191, 166, 1)
        : Colors.grey,
        shape: BoxShape.circle
      ),
    );
  }
}