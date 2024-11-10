import 'package:bakingup_frontend/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RecipeDetailInstructionImages extends StatefulWidget {
  final List<String> imageUrl;
  final bool isLoading;

  const RecipeDetailInstructionImages({
    super.key,
    required this.imageUrl,
    required this.isLoading,
  });

  @override
  State<RecipeDetailInstructionImages> createState() =>
      _RecipeDetailInstructionImagesState();
}

class _RecipeDetailInstructionImagesState
    extends State<RecipeDetailInstructionImages> {
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
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
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
                child: !widget.isLoading
                    ? Image.network(
                        '${dotenv.env['API_BASE_URL']}/${widget.imageUrl[index]}',
                        fit: BoxFit.cover,
                      )
                    : Container(),
              );
            },
          ),
        ),
        widget.imageUrl.length > 1
            ? Positioned(
                top: 170,
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
              )
            : Container()
      ],
    );
  }
}
