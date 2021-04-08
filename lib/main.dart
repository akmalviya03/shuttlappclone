import 'package:flutter/material.dart';
import 'BottomTextLast2Screen.dart';
import 'IndicatorStack.dart';
import 'constants.dart';
import 'customOpacityContainer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<double> _notifier;
  PageController _pageController;
  ValueNotifier<double> firstToSecond;

  @override
  void initState() {
    _notifier = ValueNotifier<double>(0);
    firstToSecond = ValueNotifier<double>(0);
    _pageController = PageController(
      initialPage: 0,
    )..addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_pageController.page > 1.0) {
      firstToSecond?.value = (_pageController.page - 1);
      print("First ${firstToSecond.value}");
    } else {
      _notifier?.value = _pageController.page;
      print("Second ${firstToSecond.value}");
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _notifier?.dispose();
    firstToSecond?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4f9ff),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            //PageBackground City
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Background CityScape
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/images/ob_cityscape.png'),
                ),
                //Space Below Background CityScape
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                  width: MediaQuery.of(context).size.width,
                )
              ],
            ),

            //White Tint On First Screen
            AnimatedBuilder(
              animation: _notifier,
              builder: (context, _) {
                return Opacity(
                  opacity: 0.7 - (_notifier.value / 1.45),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                  ),
                );
              },
            ),

            //PageView For Core Animation
            PageView(
              controller: _pageController,
              physics: ClampingScrollPhysics(),
              children: [
                Container(),
                Container(),
                Container(),
              ],
            ),

            //Phone On First PageView (PageController = 0)
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.27,
              right: MediaQuery.of(context).size.width * 0.015,
              child: IgnorePointer(
                ignoring: true,
                child: AnimatedBuilder(
                  animation: _notifier,
                  builder: (context, _) {
                    //Changing container Width
                    return Container(
                      width: MediaQuery.of(context).size.width -
                          MediaQuery.of(context).size.width *
                              _notifier.value /
                              1.5,
                      //Changing opacity
                      child: Opacity(
                        opacity: 1 - _notifier.value,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.03),
                          child: Image.asset('assets/images/ob_phone.png'),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            //Phone On Second PageView (PageController = 1)
            AnimatedBuilder(
              //This AnimatedBuilder Will be called when User coming to second page view from third or going to third.
              animation: firstToSecond,
              builder: (context, _) {
                //Moving Down
                return Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.26 -
                      MediaQuery.of(context).size.height *
                          0.26 *
                          firstToSecond.value,
                  right: MediaQuery.of(context).size.width * 0.035,
                  child: IgnorePointer(
                    ignoring: true,
                    //This AnimatedBuilder Will be called when User coming to second page view from first or going to first.
                    child: AnimatedBuilder(
                      animation: _notifier,
                      builder: (context, _) {
                        return Container(
                          width: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width * 1 / 1.3,
                          //Changing Opacity.
                          child: Opacity(
                            opacity: _notifier.value,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.03),
                              child: Image.asset(
                                  'assets/images/ob_phone_small.png'),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),

            //Bus on Second PageView (PageController = 1)
            AnimatedBuilder(
              //This AnimatedBuilder Will be called when User coming to second page view from first or going to first.
              animation: _notifier,
              builder: (context, _) {
                return Positioned(
                  //Moving To the Right
                  bottom: MediaQuery.of(context).size.height * 0.27,
                  left: (-MediaQuery.of(context).size.width * 0.33) +
                      _notifier.value *
                          MediaQuery.of(context).size.width *
                          0.33,
                  child: AnimatedBuilder(
                    //This AnimatedBuilder Will be called when User coming to second page view from third or going to third.
                    animation: firstToSecond,
                    builder: (context, _) {
                      //Changing Opacity
                      return Opacity(
                        opacity: 1 - firstToSecond.value,
                        child: IgnorePointer(
                          ignoring: true,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Image.asset(
                              'assets/images/ob_shuttl_cropped.png',
                              //Changing Width
                              width: MediaQuery.of(context).size.width *
                                  (firstToSecond.value + 0.3),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),

            //Bus on Third PageView (PageController = 2)
            Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.26,
                  child: AnimatedBuilder(
                    animation: firstToSecond,
                    builder: (context, _) {
                      //Changing Opacity
                      return Opacity(
                        opacity: firstToSecond.value,
                        child: IgnorePointer(
                          ignoring: true,
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Image.asset(
                              'assets/images/ob_girl_cropped.png',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

            //Bottom Sheet
            Positioned(
              bottom: 0,
              child: IgnorePointer(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.26,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Stack(
                          children: [
                            AnimatedBuilder(
                              animation: _notifier,
                              builder: (context, _) {
                                return Stack(children: [
                                  BottomText(
                                      bottomText:
                                      'Discover routes and buses near you for your daily office commute',
                                      firstToSecond: 1 - _notifier.value),
                                  BottomText(
                                      bottomText:
                                          'Reserve a seat and track your shuttl in real time for seamless boarding',
                                      firstToSecond: _notifier.value),
                                ]);
                              },
                            ),
                            //Text For Last Page.
                            AnimatedBuilder(
                              animation: firstToSecond,
                              builder: (context, _) {
                                return BottomText(
                                    bottomText:
                                        'Ride comfortably to your destination',
                                    firstToSecond: firstToSecond.value);
                              },
                            ),
                          ],
                        ),
                        //Indicator And Get Started Button
                        Stack(
                          children: [
                            //GET STARTED BUTTON FOR LAST PAGE
                            AnimatedBuilder(
                              animation: firstToSecond,
                              builder: (context, _) {
                                return Opacity(
                                  opacity: firstToSecond.value,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.05,
                                    alignment: Alignment.center,
                                    width: double.maxFinite,
                                    color: Colors.cyan,
                                    child: Text(
                                      'GET STARTED',
                                      style: kfinalScreenText,
                                    ),
                                  ),
                                );
                              },
                            ),

                            //Bottom Dots
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width *
                                      0.3,
                                  right: MediaQuery.of(context).size.width *
                                      0.3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  AnimatedBuilder(
                                    animation: _notifier,
                                    builder: (context, _) {
                                      return IndicatorStack(
                                        firstContainerOpacity: 0.3,
                                        secondContainerOpacity:
                                            1 - _notifier.value,
                                      );
                                    },
                                  ),
                                  AnimatedBuilder(
                                    animation: _notifier,
                                    builder: (context, _) {
                                      return IndicatorStack(
                                        firstContainerOpacity: 0.3,
                                        secondContainerOpacity:
                                            _notifier.value,
                                      );
                                    },
                                  ),

                                  //Last Dot Indicator means first from the right
                                  CustomOpacityContainer(
                                    opacityValue: 0.3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
