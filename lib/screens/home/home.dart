import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_bhm_app_bloc/models/home_images.dart';
import 'package:the_bhm_app_bloc/screens/home/home_payment.dart';
import 'package:the_bhm_app_bloc/state/home/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03, vertical: screenWidth * 0.02),
        child: Column(
          children: [
            SizedBox(
              height: screenWidth * 0.6,
              width: double.infinity,
              // color: Colors.blue,
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeStateInitial ||
                      state is HomeStateImagesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is HomeStateImagesLoaded) {
                    final HomeImagesModel imageData = state.homeImages;

                    // Check if imageData contains any images
                    if (imageData.data.isNotEmpty) {
                      return Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                              controller: _pageController,
                              onPageChanged: (index) {
                                setState(() {
                                  _currentPage = index;
                                });
                              },
                              itemCount: imageData.data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.network(
                                      imageData.data[index],
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, progress) {
                                        if (progress == null) return child;
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Center(
                                        child:
                                            Icon(Icons.broken_image, size: 100),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Dot indicators
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              imageData.data.length,
                              (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                height: 10,
                                width: _currentPage == index ? 12 : 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentPage == index
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    } else {
                      return const Center(child: Text("No images available"));
                    }
                  } else if (state is HomeStateError) {
                    return Center(child: Text(state.message));
                  }

                  return const Text("No images available");
                },
              ),
            ),
            // Payment Section
            const Payment()
          ],
        ),
      ),
    );
  }
}
