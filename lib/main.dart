import 'package:flutter/material.dart';

import 'dart:math';

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
  int _previousPage;
  PageController _pageController;

  @override
  void dispose() {
    _notifier?.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_pageController.page.toInt() == _pageController.page) {
      _previousPage = _pageController.page.toInt();
    }
    _notifier?.value = _pageController.page;
    setState(() {});
  }

  @override
  void initState() {
    _notifier = ValueNotifier<double>(0);
    _pageController = PageController(
      initialPage: 0,
    )..addListener(_onScroll);

    _previousPage = _pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe4f9ff),
      body: SafeArea(
        child: Column(
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
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: <Widget>[
                          Opacity(
                            opacity: 0.5 - (_notifier.value / 2),
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              color: Color(0xffe4f9ff),
                            ),
                          ),
                        ],
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
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.24,
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

                Positioned(
                  bottom: 0,
                  child: IgnorePointer(
                    child: Container(
                      height:
                      MediaQuery.of(context).size.height * 0.225,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          'Discover routes and buses near you for your daily office commute',
                          style: TextStyle(fontWeight: FontWeight.w400,fontSize: 11.5),
                        textAlign: TextAlign.center,),
                      ),
                    ),
                  ),
                ),
                
                //Phone On Second PageView
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.24,
                  right: MediaQuery.of(context).size.width * 0.015,
                  child: IgnorePointer(
                    ignoring: true,
                    child: AnimatedBuilder(
                      builder: (context, _) {
                        return Container(
                          width: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width * 1 / 1.5,
                          child: Opacity(
                            opacity: _notifier.value,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.03),
                              child: Image.asset(
                                  'assets/images/ob_phone_small.png'),
                            ),
                          ),
                        );
                      },
                      animation: _notifier,
                    ),
                  ),
                )
              ]),
            ),
            AnimatedBuilder(
              animation: _notifier,
              builder: (context, _) {
                return Text(
                  _notifier.value.toString(),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
