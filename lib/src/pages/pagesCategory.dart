import 'package:flutter/material.dart';
import 'package:markets/src/elements/DrawerWidget.dart';
import 'package:markets/src/elements/FilterWidget.dart';
import 'package:markets/src/helpers/helper.dart';
import 'package:markets/src/models/route_argument.dart';
import 'package:markets/src/pages/category.dart';
import 'package:markets/src/pages/favorites.dart';
import 'package:markets/src/pages/home.dart';
import 'package:markets/src/pages/login.dart';
import 'package:markets/src/pages/notifications.dart';
import 'package:markets/src/pages/orders.dart';
import 'package:markets/src/pages/profile.dart';
import 'package:markets/src/repository/user_repository.dart';

// ignore: must_be_immutable
class PagesCategory extends StatefulWidget {
  dynamic currentTab;
  dynamic catId;
  RouteArgument routeArgument;
  Widget currentPage = CategoryWidget();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  PagesCategory({Key key, RouteArgument routeArgument}) {
    if (routeArgument.id != null) {
      catId = routeArgument.id;
    }
    if (currentTab != null) {
      if (currentTab is RouteArgument) {
        routeArgument = currentTab;
        currentTab = int.parse(currentTab.id);
      }
    } else {
      currentTab = 2;
    }
  }

  @override
  _PagesCategoryState createState() {
    return _PagesCategoryState();
  }
}

class _PagesCategoryState extends State<PagesCategory> {
  initState() {
    super.initState();
    print(widget.currentTab);
    _selectTab(widget.currentTab);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage =
              NotificationsWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 1:
          widget.currentPage = currentUser.value.apiToken != null
              ? ProfileWidget(parentScaffoldKey: widget.scaffoldKey)
              : LoginWidget();
          break;
        case 2:
          widget.currentPage =
              // HomeWidget(parentScaffoldKey: widget.scaffoldKey);
              CategoryWidget(routeArgument: RouteArgument(id: widget.catId));
          break;
        case 3:
          widget.currentPage =
              OrdersWidget(parentScaffoldKey: widget.scaffoldKey);
          break;
        case 4:
          widget.currentPage = FavoritesWidget();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        key: widget.scaffoldKey,
        drawer: DrawerWidget(),
        endDrawer: FilterWidget(onFilter: (filter) {
          Navigator.of(context)
              .pushReplacementNamed('/Pages', arguments: widget.currentTab);
        }),
        body: widget.currentPage,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).accentColor,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          iconSize: 22,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedIconTheme: IconThemeData(size: 28),
          unselectedItemColor: Theme.of(context).focusColor.withOpacity(1),
          currentIndex: widget.currentTab,
          onTap: (int i) {
            if (i == 2) {
              // Navigator.of(context).pushNamed('/Pages', arguments: 2);
              Navigator.pop(context);
            }
            this._selectTab(i);
          },
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Icon(widget.currentTab == 0
                  ? Icons.notifications
                  : Icons.notifications_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  widget.currentTab == 1 ? Icons.person : Icons.person_outline),
              label: '',
            ),
            BottomNavigationBarItem(
                label: '',
                icon: Container(
                  width: 42,
                  height: 42,
                  margin: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).accentColor.withOpacity(0.4),
                          blurRadius: 40,
                          offset: Offset(0, 15)),
                      BoxShadow(
                          color: Theme.of(context).accentColor.withOpacity(0.4),
                          blurRadius: 13,
                          offset: Offset(0, 3))
                    ],
                  ),
                  child: new Icon(
                      widget.currentTab == 2 ? Icons.home : Icons.home_outlined,
                      color: Theme.of(context).primaryColor),
                )),
            BottomNavigationBarItem(
              icon: new Icon(widget.currentTab == 3
                  ? Icons.local_mall
                  : Icons.local_mall_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: new Icon(widget.currentTab == 4
                  ? Icons.favorite
                  : Icons.favorite_border_outlined),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
