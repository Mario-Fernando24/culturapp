import 'package:culturappco/config/themes/app_style.dart';
import 'package:culturappco/config/themes/size_config.dart';
import 'package:culturappco/domain/models/onbording.dart';
import 'package:culturappco/utils/constants/constant_routes.dart';
import 'package:flutter/material.dart';

class OnbordingView extends StatefulWidget {
  const OnbordingView({super.key});

  @override
  State<OnbordingView> createState() => _OnbordingViewState();
}

class _OnbordingViewState extends State<OnbordingView> {
  int currentPage = 0;
  PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer doIndicator(index) {
    return  AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 400),
      height: 10,
      width: 10,
      decoration: BoxDecoration(
          color: currentPage == index
              ? kPrimaryColor
              : Color.fromARGB(255, 82, 80, 80),
          shape: BoxShape.circle),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // ignore: unused_local_variable
    double sizeH = SizeConfig.blockSizeH!;
    // ignore: unused_local_variable
    double sizeV = SizeConfig.blockSizeV!;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 9,
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingContents.length,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemBuilder: (context, index) => Stack(
                          children: [
                            Positioned.fill(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 00),
                                child: Image.asset(
                                  onboardingContents[index].image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            index<5? Positioned(
                                top: SizeConfig.blockSizeH! * 4.0,
                                left: SizeConfig.screenWidth! * 0.82,
                                right: 10,
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, homeUserviewRoutes);
                                    },
                                    child: Text('omitir',
                                        style: TextStyle(
                                            color:index==2? Colors.black: Colors.white,
                                            decoration:
                                                TextDecoration.underline,
                                            fontSize: 14.0)))):Container(),
                            Positioned(
                              top: SizeConfig.blockSizeH! * 180,
                              left: 10,
                              right: 10,
                              child: Column(
                                children: [
                                  currentPage == onboardingContents.length - 1
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          child: SizedBox(
                                            height:
                                                SizeConfig.blockSizeH! * 14.5,
                                            width: SizeConfig.blockSizeV! * 100,
                                            child: Container(
                                              margin: EdgeInsets.only(top: 10),
                                              width:
                                                  SizeConfig.screenWidth! * 0.3,
                                              height:
                                                  SizeConfig.blockSizeH! * 12,
                                              child: ElevatedButton(
                                               style: ElevatedButton.styleFrom(
                                                  primary: kPrimaryColor,
                                                  onPrimary: Colors.white,
                                                  side: BorderSide(
                                                      color: kPrimaryColor),
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                      context, homeUserviewRoutes);
                                                },
                                                child: Text(
                                                  'EMPEZAR',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                           index>0? Container(
                                              margin: EdgeInsets.only(top: 10),
                                              width:
                                                  SizeConfig.screenWidth! * 0.3,
                                              height:
                                                  SizeConfig.blockSizeH! * 12,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: kPrimaryColor,
                                                  onPrimary: Colors.white,
                                                  side: BorderSide(
                                                      color: kPrimaryColor),
                                                ),
                                                onPressed: () {
                                                  _pageController.previousPage(
                                                      duration: Duration(
                                                          microseconds: 400),
                                                      curve: Curves.easeInOut);
                                                },
                                                child: Text(
                                                  'ANTERIOR',
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ):Container(),
                                          index>0?  Row(
                                              children: List.generate(
                                                  onboardingContents.length,
                                                  (index) =>
                                                      doIndicator(index)),
                                            ):Container(),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              width:
                                                index==0 ? SizeConfig.screenWidth! * 0.9:SizeConfig.screenWidth! * 0.3,
                                              height:
                                                  SizeConfig.blockSizeH! * 12,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: kPrimaryColor,
                                                  onPrimary: Colors.white,
                                                  side: BorderSide(
                                                      color: kPrimaryColor),
                                                ),
                                                onPressed: () {
                                                  _pageController.nextPage(
                                                      duration: Duration(
                                                          microseconds: 400),
                                                      curve: Curves.easeInOut);
                                                },
                                                child: Text('SIGUIENTE',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            )
                          ],
                        ))),
          ],
        ),
      ),
    );
  }
}

class OnbordingNavBt extends StatelessWidget {
  const OnbordingNavBt({
    super.key,
    required this.name,
    required this.onPress,
  });

  final String name;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPress,
        borderRadius: BorderRadius.circular(6),
        splashColor: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: kBodyText1,
          ),
        ));
  }
}
