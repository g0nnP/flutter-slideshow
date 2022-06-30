import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {

  final Color activeBulletColor;
  final List<Widget> slides;
  final Color bulletColor;
  final bool upDots;
  final double bullet;
  final double activeBullet;

  const SlideShow({
    super.key, 
    this.upDots = false,
    required this.slides,
    this.bulletColor = Colors.grey,
    this.activeBulletColor = Colors.blue,
    this.bullet = 12,
    this.activeBullet = 15
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SliderShowModel(),
      child: SafeArea(
        child: Center(
          child: Builder(
            builder: (BuildContext context) {
              Future.delayed(
                const Duration(milliseconds: 0),
                () {
                  Provider.of<_SliderShowModel>(context, listen: false).setBulletColor
                    = bulletColor;

                  Provider.of<_SliderShowModel>(context, listen: false).setActiveBulletColor
                    = activeBulletColor;

                  Provider.of<_SliderShowModel>(context, listen: false).setActiveBullet
                    = activeBullet;

                  Provider.of<_SliderShowModel>(context, listen: false).setBullet
                    = bullet;
                }
              );
              return _SlideShowStructure(
                upDots: upDots,
                slides: slides,
                activeBulletColor: activeBulletColor,
                bulletColor: bulletColor
              );
            },
          )
        ),
      ),
    );
  }
}

class _SlideShowStructure extends StatelessWidget {
  const _SlideShowStructure({
    Key? key,
    required this.upDots,
    required this.slides,
    required this.activeBulletColor,
    required this.bulletColor,
  }) : super(key: key);

  final bool upDots;
  final List<Widget> slides;
  final Color activeBulletColor;
  final Color bulletColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(upDots) _Dots(slides.length, activeBulletColor, bulletColor),
        Expanded(child: _Slides(slides)),
        if(!upDots) _Dots(slides.length, activeBulletColor, bulletColor),
      ],
    );
  }
}

class _Dots extends StatelessWidget {

  final int totalSlides;
  final Color bulletColor;
  final Color activeBulletColor;

  const _Dots(this.totalSlides, this.activeBulletColor, this.bulletColor);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSlides, (index) => _Dot(index)),
      )
    );
  }
}

class _Dot extends StatelessWidget {

  final int index;

  const _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final p = Provider.of<_SliderShowModel>(context);
    return AnimatedContainer(
      width: dotSize(p),
      height: dotSize(p),
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: (p.getCurrentPage >= index - 0.5 && p.getCurrentPage < index + 0.5)
        ? p.getActiveBulletColor
        : p.getBulletColor,
        shape: BoxShape.circle
      ),
    );
  }

  double dotSize(_SliderShowModel p) {
    if(p.getCurrentPage >= index - 0.5 && p.getCurrentPage < index + 0.5) {
      return p.getActiveBullet;
    } else {
      return p.getBullet;
    }
  }
}

class _Slide extends StatelessWidget {

  final Widget widget;

  const _Slide(this.widget);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: widget,
    );
  }
}

class _Slides extends StatefulWidget {

  final List<Widget> slides;

  const _Slides(this.slides);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {

  late PageController pViewController;

  @override
  void initState() {
    pViewController = PageController();
    pViewController.addListener(() {
      Provider.of<_SliderShowModel>(context, listen: false).setCurrentPage
        = pViewController.page!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: PageView(
        controller: pViewController,
        children: widget.slides.map(
            (e) => _Slide(e)
        ).toList()
      ),
    );
  }
}

class _SliderShowModel with ChangeNotifier {
  double _currentpage = 0;
  Color _bulletColor = Colors.grey;
  Color _activeBulletColor = Colors.blue;
  double _bullet = 12;
  double _activeBullet = 15;

  double get getCurrentPage => _currentpage;

  set setCurrentPage(double page) {
    _currentpage = page;
    notifyListeners();
  }

  Color get getBulletColor => _bulletColor;

  set setBulletColor(Color color) {
    _bulletColor = color;
    notifyListeners();
  }

  Color get getActiveBulletColor => _activeBulletColor;

  set setActiveBulletColor(Color color) {
    _activeBulletColor = color;
    notifyListeners();
  }

  double get getBullet => _bullet;

  set setBullet(double size) {
    _bullet = size;
    notifyListeners();
  }

  double get getActiveBullet => _activeBullet;

  set setActiveBullet(double size) {
    _activeBullet = size;
    notifyListeners();
  }
}