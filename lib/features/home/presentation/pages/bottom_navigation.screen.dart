import 'package:flutter/material.dart';
import 'package:task_it/Data/Repositories/user.repo.dart';
import 'package:task_it/features/inbox/presentation/pages/inbox.screen.dart';

import '../../../../Data/Model/Member/member.model.dart';
import '../../../authentication/domain/repositories/AuthService.dart';
import '../../../search/presentation/pages/search.screen.dart';
import 'home.screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  final bool firstTime;

  const BottomNavigationScreen({Key? key, this.firstTime = false})
      : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  late PageController pageController;
  int _selectedIndex = 0;
  Member? member;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    MemberRepo().readSingle(AuthService().getCurrentUserId()).then((value) {
      setState(() {
        member = value;
        isLoaded = true;
      });
    });
  }

  Future<void> onItemTapped(int index) async {
    await pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (member != null && isLoaded)
          ? PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                HomeScreen(
                  member: member!,
                  firstTime: widget.firstTime,
                ),
                SearchScreen(
                  member: member!,
                ),
                InboxScreen(
                  teamId: member?.teamId,
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
