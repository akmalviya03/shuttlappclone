import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageView Scrolling',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  void dispose() {
    _notifier?.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_pageController.page > 1.0) {
      firstToSecond?.value = (_pageController.page - 1);
      print(firstToSecond.value);
    } else {
      _notifier?.value = _pageController.page;
    }
  }

  @override
  void initState() {
    _notifier = ValueNotifier<double>(0);
    firstToSecond = ValueNotifier<double>(0);
    _pageController = PageController(
      initialPage: 0,
    )..addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4f9ff),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(children: [
              IgnorePointer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset('assets/images/ob_cityscape.png'),
                    ),
                    Container(
                      height: 10,
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xffb9ac92),
                    )
                  ],
                ),
              ),
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
              PageView(
                physics: ClampingScrollPhysics(),
                children: [
                  Container(),
                  Container(),
                  Container(),
                ],
                controller: _pageController,
              ),

              //Phone On First PageView
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.27,
                right: MediaQuery.of(context).size.width * 0.015,
                child: IgnorePointer(
                  ignoring: true,
                  child: AnimatedBuilder(
                    builder: (context, _) {
                      return Container(
                        width: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.width *
                                _notifier.value /
                                1.5,
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
                    animation: _notifier,
                  ),
                ),
              ),
              //Phone On Second PageView
              AnimatedBuilder(
                builder: (context, _) {
                  return Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.26 -
                        MediaQuery.of(context).size.height *
                            0.26 *
                            firstToSecond.value,
                    right: MediaQuery.of(context).size.width * 0.035,
                    child: IgnorePointer(
                      ignoring: true,
                      child: AnimatedBuilder(
                        builder: (context, _) {
                          return Container(
                            width: MediaQuery.of(context).size.width -
                                MediaQuery.of(context).size.width * 1 / 1.3,
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
                        animation: _notifier,
                      ),
                    ),
                  );
                },
                animation: firstToSecond,
              ),
              //Bus on Second PageView
              AnimatedBuilder(
                builder: (context, _) {
                  return Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.27,
                    left: (-MediaQuery.of(context).size.width * 0.33) +
                        _notifier.value *
                            MediaQuery.of(context).size.width *
                            0.33,
                    child: AnimatedBuilder(
                      builder: (context, _) {
                        return Opacity(
                          opacity: 1 - firstToSecond.value,
                          child: IgnorePointer(
                            ignoring: true,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Image.asset(
                                'assets/images/ob_shuttl_cropped.png',
                                width: MediaQuery.of(context).size.width *
                                    (firstToSecond.value + 0.3),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      },
                      animation: firstToSecond,
                    ),
                  );
                },
                animation: _notifier,
              ),

              //Bus on Third PageView
              AnimatedBuilder(
                builder: (context, _) {
                  return Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.26,
                    child: AnimatedBuilder(
                      builder: (context, _) {
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
                      animation: firstToSecond,
                    ),
                  );
                },
                animation: _notifier,
              ),

              //Bottom Sheet
              Positioned(
                bottom: 0,
                child: SafeArea(
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
                                  builder: (context, _) {
                                    return Stack(children: [
                                      Opacity(
                                        opacity: 1 - _notifier.value,
                                        child: Container(
                                          color: Colors.white,
                                          width: double.maxFinite,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.1,
                                          child: Text(
                                            'Discover routes and buses near you for your daily office commute',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Opacity(
                                        opacity: _notifier.value,
                                        child: Container(
                                          color: Colors.white,
                                          width: double.maxFinite,
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.1,
                                          child: Text(
                                            'Reserve a seat and track your shuttl in real time for seamless boarding',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ]);
                                  },
                                  animation: _notifier,
                                ),
                                AnimatedBuilder(
                                  builder: (context, _) {
                                    return Opacity(
                                      opacity: firstToSecond.value,
                                      child: Container(
                                        color: Colors.white,
                                        width: double.maxFinite,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        child: Text(
                                          'Ride comfortably to your destination',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  },
                                  animation: firstToSecond,
                                ),
                              ],
                            ),
                            Stack(children: [
                              AnimatedBuilder(
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
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                                },
                                animation: firstToSecond,
                              ),
                              Opacity(
                                opacity: 1 - firstToSecond.value,
                                child: Padding(
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
                                        builder: (context, _) {
                                          return ClipOval(
                                            child: Stack(children: [
                                              Opacity(
                                                opacity: 0.3,
                                                child: Container(
                                                  height: 15,
                                                  width: 15,
                                                  color: Colors.cyan,
                                                ),
                                              ),
                                              Opacity(
                                                opacity: 1 - _notifier.value,
                                                child: Container(
                                                  height: 15,
                                                  width: 15,
                                                  color: Colors.cyan,
                                                ),
                                              ),
                                            ]),
                                          );
                                        },
                                        animation: _notifier,
                                      ),
                                      AnimatedBuilder(
                                        builder: (context, _) {
                                          return ClipOval(
                                            child: Stack(children: [
                                              Opacity(
                                                opacity: 0.3,
                                                child: Container(
                                                  height: 15,
                                                  width: 15,
                                                  color: Colors.cyan,
                                                ),
                                              ),
                                              Opacity(
                                                opacity: _notifier.value,
                                                child: Container(
                                                  height: 15,
                                                  width: 15,
                                                  color: Colors.cyan,
                                                ),
                                              ),
                                            ]),
                                          );
                                        },
                                        animation: _notifier,
                                      ),

                                      //Last Dot Indicator means first from the right

                                      Opacity(
                                        opacity: 0.2,
                                        child: ClipOval(
                                          child: Container(
                                            height: 15,
                                            width: 15,
                                            color: Colors.cyan,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ])
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
