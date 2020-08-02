import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid_app/model/country.dart';
import 'package:covid_app/model/global_report.dart';
import 'package:covid_app/utils/repository.dart';
import 'package:covid_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key key, this.repository}) : super(key: key);

  final Repository repository;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final CarouselController pageController = CarouselController();
  AnimationController animationController;
  AnimationController buttonAnimationController;
  Animation<double> start, end;
  Animation<double> floatButtonSize;
  Animation<double> floatButtonOpacity;
  Animation<Color> color;
  Future<GlobalReport> getGlobalReport;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    getGlobalReport = widget.repository.getGlobalReport();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200), )
      ..addListener(() { setState(() {}); });
    start = Tween<double>(begin: 0.75, end: 0).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    end = Tween<double>(begin: 1, end: 0.75).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));
    color = ColorTween(begin: Colors.white, end: Colors.black).animate(CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));

    buttonAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: 200), )
      ..addListener(() { setState(() {}); });
    floatButtonSize = Tween<double>(begin: 50, end: 250).animate(CurvedAnimation(parent: buttonAnimationController, curve: Curves.ease));
    floatButtonOpacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: buttonAnimationController, curve: Curves.ease));
  }

  bool get isEnd => floatButtonSize.value == 250;


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 414, height: 896);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ AppColors.red, AppColors.white, AppColors.white, AppColors.grey],
            stops: [start.value, start.value, end.value, end.value]
          )
        ),
        child: SingleChildScrollView(
          child: Container(
            height: ScreenUtil.screenHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 85),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Made by Nghia', style: TextStyle(color: color.value)),
                      IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () {
                          if (_currentIndex != 0)
                            pageController.animateToPage(0);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text('Covid-19\nPandemic Report',
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyText1,
                        color: color.value,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.2,
                      )),
                ),
                SizedBox(height: 36),
                FutureBuilder<GlobalReport>(
                  future: getGlobalReport,
                  builder: (context, snapshot) {
                    final isLoaded = snapshot.connectionState == ConnectionState.done;
                    final globalReport = snapshot.data;
                    if (isLoaded) {
                      return Container(
                        width: ScreenUtil.screenWidth,
                        padding: EdgeInsets.zero,
                        child: CarouselSlider.builder(
                          carouselController: pageController,
                          itemCount: isLoaded ? globalReport.total : 10,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 305,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(22)),
                                  image: DecorationImage(image: AssetImage(globalReport.getCorrespondingImage(index)), fit: BoxFit.cover),
                              ),
                              child: ReportCard(report: globalReport.getDecorDisplayedList()[index]),
                            );
                          },
                          options: CarouselOptions(
                              height: 500,
                              viewportFraction: 0.75,
                              initialPage: 0,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              onPageChanged: (index, reason) {
                                if (index == 0) {
                                  animationController.reverse();
                                } else if (index == 1) {
                                  animationController.forward();
                                }
                                _currentIndex = index;
                              }
                          ),
                        ),
                      );
                    }
                    return Container();
                  }
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
          width: floatButtonSize.value,
          child: FloatingActionButton.extended(
            backgroundColor: AppColors.white,
            label: Row(
              children: [
                FadeTransition(
                  opacity: floatButtonOpacity,
                  child: Container(
                    width: floatButtonSize.value - 50,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter country'
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (!isEnd) {
                      buttonAnimationController.forward();
                    } else {
                      buttonAnimationController.reverse();
                    }
                  },
                  child: Image.asset(AppImages.icSearch)),
              ],
            ))),
    );
  }
}

class ReportCard extends StatefulWidget {
  final CountryReport report;

  const ReportCard({Key key, this.report}) : super(key: key);

  @override
  _ReportCardState createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> with TickerProviderStateMixin {
  static const double mileStone_1 = 0.0;
  static const double mileStone_1a = 0.2;
  static const double mileStone_2 = 0.4;
  static const double mileStone_3 = 1.0;
  AnimationController animationController;
  Animation<Offset> goUpFastAnimation;
  Animation<Offset> goUpDownFastAnimation;
  Animation<Offset> goUpAnimation;
  Animation<double> upOpacityAnimation;
  Animation<double> downOpacityAnimation;
  Animation<Offset> slideRightAnimation;
  Animation<Offset> slideLeftAnimation;
  Animation<double> slideOpacityAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
    ..addListener(() { setState(() {}); });

    goUpFastAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(0, -18)).animate(CurvedAnimation(parent: animationController, curve: Interval(mileStone_1, mileStone_2, curve: Curves.ease)));
    goUpAnimation = Tween<Offset>(begin: Offset.zero, end: Offset(0, -5)).animate(CurvedAnimation(parent: animationController, curve: Interval(mileStone_1, mileStone_2, curve: Curves.ease)));
    upOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Interval(mileStone_1a, mileStone_2, curve: Curves.ease)));
    goUpDownFastAnimation = Tween<Offset>(begin: Offset(0, -18), end: Offset.zero).animate(CurvedAnimation(parent: animationController, curve: Interval(mileStone_2, mileStone_3, curve: Curves.ease)));
    downOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Interval(mileStone_2, mileStone_3, curve: Curves.ease)));
    slideRightAnimation = Tween<Offset>(begin: Offset(-2, 0), end: Offset.zero).animate(CurvedAnimation(parent: animationController, curve: Interval(mileStone_2, mileStone_3, curve: Curves.ease)));
    slideLeftAnimation = Tween<Offset>(begin: Offset(2, 0), end: Offset.zero).animate(CurvedAnimation(parent: animationController, curve: Interval(mileStone_2, mileStone_3, curve: Curves.ease)));
    slideOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController, curve: Interval(mileStone_2, mileStone_3, curve: Curves.ease)));
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        FadeTransition(
          opacity: upOpacityAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SlideTransition(
                  position: goUpFastAnimation,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      animationController.forward();
                    },
                    child: Lottie.asset(
                      'json/up2.json',
                      height: 36,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              SlideTransition(
                position: goUpAnimation,
                child: Text(widget.report.totalConfirmed?.readable ?? '',
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.bodyText1,
                    color: AppColors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 50.0, left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text('Total cases in ${widget.report.country}',
                        style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          color: AppColors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SlideTransition(
                position: goUpDownFastAnimation,
                child: InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    animationController.reverse();
                  },
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Lottie.asset(
                      'json/up2.json',
                      height: 36,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            FadeTransition(
              opacity: slideOpacityAnimation,
              child: SlideTransition(
                position: slideRightAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.report.totalDeaths.readable ?? '',
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyText1,
                        color: AppColors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text('Total Deaths',
                        style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FadeTransition(
              opacity: slideOpacityAnimation,
              child: SlideTransition(
                position: slideLeftAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.report.totalRecovered.readable,
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyText1,
                        color: AppColors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text('Total Recovery',
                        style: GoogleFonts.lato(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          color: AppColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
