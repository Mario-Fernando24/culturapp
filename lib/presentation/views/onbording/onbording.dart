import 'package:culturappco/domain/models/onbording.dart';
import 'package:flutter/material.dart';

class OnbordingView extends StatefulWidget {
  const OnbordingView({super.key});

  @override
  State<OnbordingView> createState() => _OnbordingViewState();
}

class _OnbordingViewState extends State<OnbordingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: PageView.builder(
              itemCount: onboardingContents.length,
              itemBuilder: (context, index)=>
              Text(onboardingContents[index].title)
          ))
          ],
        ),
      ),
    );
  }
}