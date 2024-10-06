import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BakingUpDetailImage extends StatefulWidget {
  final List<String> imageUrl;
  final bool isLoading;

  const BakingUpDetailImage({
    super.key,
    required this.imageUrl,
    required this.isLoading,
  });

  @override
  State<BakingUpDetailImage> createState() => _IngredientDetailImageState();
}

class _IngredientDetailImageState extends State<BakingUpDetailImage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Stack(
        children: [
          Center(
            child: Shimmer.fromColors(
              baseColor: greyColor,
              highlightColor: whiteColor,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.width / 0.8),
                color: Colors.white,
              ),
            ),
          ),
          if (widget.isLoading == false) ...[
            if (widget.imageUrl.isNotEmpty) ...[
              SizedBox(
                height: MediaQuery.of(context).size.width / 1.5 + 20,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.imageUrl.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if (_currentPage == 0 && details.delta.dx > 0) {
                          return;
                        }
                        _pageController.position.moveTo(
                            _pageController.position.pixels - details.delta.dx);
                      },
                      child: Image.network(
                        widget.imageUrl[index],
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.width / 1.5 - 30,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: widget.imageUrl.length,
                      effect: WormEffect(
                        dotHeight: 8.0,
                        dotWidth: 8.0,
                        spacing: 3.0,
                        dotColor: darkGreyColor.withOpacity(0.3),
                        activeDotColor: darkGreyColor,
                      ),
                    ),
                  ),
                ),
              ),
            ] else ...[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.width / 0.8),
                color: yellowColor,
              )
            ]
          ]
        ],
      ),
    );
  }
}
