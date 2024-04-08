import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavBarWidget extends StatelessWidget {
  final int currentIndex;
  final void Function(int)? onTap;
  const NavBarWidget({super.key, required this.currentIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 30,
                offset: const Offset(0, 10))
          ],
          borderRadius: BorderRadius.circular(30)),
      child: ClipRRect(
        /* borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        ), */
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          unselectedItemColor: Color.fromARGB(255, 49, 150, 153),
          selectedItemColor: Color.fromARGB(255, 50, 100, 175),
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: currentIndex,
          iconSize: 25,
          onTap: onTap, //_onItemTapped
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home
                    // Icons.home,
                    ),
                label: ""),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.time
                  //Icons.bar_chart,
                  ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.play_rectangle),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.bookmark_fill,
                // Icons.bookmark,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search
                    // Icons.search_rounded,
                    ),
                label: ""),
            /* BottomNavigationBarItem(
              icon: Icon(
                //CupertinoIcons.about
                Icons.contact_page_rounded,
              ),
              label: "",
            ), */
            BottomNavigationBarItem(
              icon: Icon(Icons.person), //Icon(CupertinoIcons.info),
              label: "",
              /*  final snackBar =               
                             SnackBar(
                              content: Text('snackMessage',textAlign: TextAlign.center,),
                              backgroundColor: Colors.red,
                            ); */
              /*    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                    (route) => false); */
            )
          ],
        ),
      ),
    );
  }
}
