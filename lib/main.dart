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
              PageView(
                physics: ClampingScrollPhysics(),
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: <Widget>[
                        AnimatedBuilder(
                          animation: _notifier,
                          builder: (context, _) {
                            return Opacity(
                              opacity: 0.5 - (_notifier.value / 2),
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                color: Color(0xffe4f9ff),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Align(
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Align(
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ],
                controller: _pageController,
              ),

              //Phone On First PageView
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.29,
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
                                left:
                                    MediaQuery.of(context).size.width * 0.03),
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
              AnimatedBuilder(builder: (context, _) {
                return Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.28 - MediaQuery.of(context).size.height * 0.28*firstToSecond.value,
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
              }, animation: firstToSecond,),
              //Bus on Second PageView
              AnimatedBuilder(
                builder: (context, _) {
                  return Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.29,
                    left: (-MediaQuery.of(context).size.width * 0.33) +
                        _notifier.value *
                            MediaQuery.of(context).size.width *
                            0.33,
                    child: AnimatedBuilder(
                      builder: (context, _) {
                        return Opacity(
                          opacity: 1-firstToSecond.value,
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
                    bottom: MediaQuery.of(context).size.height * 0.28,
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
                child: IgnorePointer(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.28,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Discover routes and buses near you for your daily office commute',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 11.5),
                        textAlign: TextAlign.center,
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
