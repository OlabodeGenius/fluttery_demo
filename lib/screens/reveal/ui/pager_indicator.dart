import 'package:flutter/material.dart';
import 'package:fluttery_demo/models/page_bubble_view_model.dart';
import 'package:fluttery_demo/models/page_indicator_view_model.dart';
import 'package:fluttery_demo/screens/reveal/enums.dart';
import 'package:fluttery_demo/screens/reveal/ui/page_bubble.dart';



class PagerIndicator extends StatelessWidget {

  final PagerIndicatorViewModel viewModel;

  PagerIndicator({
    this.viewModel
  });

  @override
  Widget build(BuildContext context) {
    List<PageBubble> bubbles = [];

    for (var i = 0; i < viewModel.pages.length; ++i) {
      final page = viewModel.pages[i];

      var percentActive;
      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 && viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 && viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      bool isHollow = i > viewModel.activeIndex
          || (i == viewModel.activeIndex && viewModel.slideDirection == SlideDirection.leftToRight);

      bubbles.add(
        PageBubble(
          viewModel: PageBubbleViewModel(
            page.iconAssetPath,
            page.color,
            isHollow,
            percentActive,
          ),
        ),
      );
    }

    const BUBBLE_WIDTH = 55.0;
    final baseTranslation = ((viewModel.pages.length * BUBBLE_WIDTH) / 2) - (BUBBLE_WIDTH / 2);
    var translation = baseTranslation - (viewModel.activeIndex * BUBBLE_WIDTH);
    
    if (viewModel.slideDirection == SlideDirection.leftToRight) {
      translation += BUBBLE_WIDTH * viewModel.slidePercent;
    } else if (viewModel.slideDirection == SlideDirection.rightToLeft) {
      translation -= BUBBLE_WIDTH * viewModel.slidePercent;
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(child: Container()),

          Transform(
            transform: Matrix4.translationValues(translation, 0.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bubbles,
            ),
          ),

          SizedBox(
            height: 88.0,
          ),
        ]
      ),
    );
  }
}