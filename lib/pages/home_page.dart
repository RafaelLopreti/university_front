import 'package:flutter/material.dart';
import 'package:university_front/components/course_card.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Timer? _timer;
  final int bannerSeconds = 5;
  final int secondsTransition = 2;
  int _selectedNavIndex = 0;
  late AnimationController _animationController;

  final List<String> _courses =
      List.generate(8, (index) => 'Curso ${index + 1}');
  List<String> _filteredCourses = [];
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _filteredCourses = List.from(_courses);

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: bannerSeconds), (timer) {
      if (_currentPage < 2) {
        _pageController.nextPage(
          duration: Duration(seconds: secondsTransition),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: Duration(seconds: secondsTransition),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onNavItemTapped(int index) {
    if (index == _selectedNavIndex) {
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    } else {
      setState(() {
        _selectedNavIndex = index;
        _isSearching = index == 1;

        if (!_isSearching) {
          _filteredCourses = List.from(_courses);
        }
      });

      if (index == 1) {
        _searchController.clear();
        _filterCourses('');
      } else if (index == 2) {
        Navigator.pushNamed(context, '/profile').then((_) {
          setState(() {
            _selectedNavIndex = 0;
            _isSearching = false;
            _filteredCourses = List.from(_courses);
          });
        });
      }
    }
  }

  void _filterCourses(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCourses = List.from(_courses);
      } else {
        _filteredCourses = _courses
            .where(
                (course) => course.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    Container(
                      color: Colors.green,
                      child: const Center(
                        child: Text(
                          'Banner 1',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.yellow,
                      child: const Center(
                        child: Text(
                          'Banner 2',
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.red,
                      child: const Center(
                        child: Text(
                          'Banner 3',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (index) {
                      return IndicatorDot(isActive: _currentPage == index);
                    }),
                  ),
                ),
              ],
            ),
          ),
          if (_isSearching)
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
              child: TextField(
                controller: _searchController,
                onChanged: _filterCourses,
                decoration: InputDecoration(
                  labelText: 'Search courses',
                  labelStyle: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _filterCourses('');
                    },
                  ),
                ),
              ),
            ),
          Expanded(
            child: _filteredCourses.isNotEmpty
                ? GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: _filteredCourses.length,
                    itemBuilder: (context, index) {
                      return CourseCard(
                        title: _filteredCourses[index],
                        period: 'Período: Manhã',
                        duration: 'Duração: ${index + 1} meses',
                        image: '',
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      'Curso não encontrado.',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(bottom: 20, left: 10, right: 10, top: 10),
        child: Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, 'Home', 0),
              _buildNavItem(Icons.search_outlined, 'Search', 1),
              _buildNavItem(Icons.person_outline, 'Profile', 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedNavIndex == index;

    return GestureDetector(
      onTap: () => _onNavItemTapped(index),
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: isSelected ? 1.1 : 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.blue : Colors.white,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.blue : Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IndicatorDot extends StatelessWidget {
  final bool isActive;

  const IndicatorDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
