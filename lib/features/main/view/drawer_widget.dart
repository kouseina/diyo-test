// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final double _drawerExpandWidth = 320;
  final double _drawerCloseWidth = 100;

  bool _isDrawerExpand = true;

  void _onDrawerToggle() {
    setState(() {
      _isDrawerExpand = !_isDrawerExpand;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 110),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      width: _isDrawerExpand ? _drawerExpandWidth : _drawerCloseWidth,
      decoration: BoxDecoration(
        color: Colors.red.shade400,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: _onDrawerToggle,
                child: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              NavTile(
                isDrawerExpand: _isDrawerExpand,
                title: "Home",
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              NavTile(
                isDrawerExpand: _isDrawerExpand,
                title: "Order Queue",
                icon: const Icon(
                  Icons.check_box_outlined,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              NavTile(
                isDrawerExpand: _isDrawerExpand,
                title: "Menu",
                icon: const Icon(
                  Icons.dashboard,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: NavTile(
                  isDrawerExpand: _isDrawerExpand,
                  title: "Logout",
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            child: AnimatedOpacity(
              opacity: _isDrawerExpand ? 1 : 0,
              duration: const Duration(milliseconds: 440),
              child: InkWell(
                onTap: _onDrawerToggle,
                child: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavTile extends StatelessWidget {
  bool isDrawerExpand;
  Widget? icon;
  String title;

  NavTile({
    Key? key,
    required this.isDrawerExpand,
    this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Row(
        children: [
          icon ?? const SizedBox.shrink(),
          if (icon != null && isDrawerExpand) const SizedBox(width: 20),
          Visibility(
            visible: isDrawerExpand,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
