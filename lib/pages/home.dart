import 'package:cmpe277_project/pages/me.dart';
import 'package:cmpe277_project/pages/my_favorite.dart';
import 'package:cmpe277_project/pages/recommendation.dart';
import 'package:cmpe277_project/pages/search.dart';
import 'package:cmpe277_project/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _currentIdx = 0;

  @override
  void initState() {
    super.initState();
  }

  _updateIndex(int index) {
    // widget.onTabSelected(index);
    setState(() {
      _currentIdx = index;
    });
  }

  buildTabItem(
      {String text,
      IconData icon,
      Color textColor,
      int index,
      ValueChanged<int> onPressed,
      theme}) {
    return Expanded(
      child: SizedBox(
        height: 70,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon,
                    color: _currentIdx == index ? textColor : theme.textColor,
                    size: 30),
                Text(
                  text,
                  style: TextStyle(
                      color: _currentIdx == index ? textColor : theme.textColor,
                      fontSize: 14),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  currentPage() {
    switch (_currentIdx) {
      case 0:
        return new Search();
      case 1:
        return new Recommendation();
      case 2:
        return new MyFavorite();
      case 3:
        return new Me();
      default:
        return new Search();
    }
  }

  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double hrpx = MediaQuery.of(context).size.height / 750;
    final theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Color(theme.primaryColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildTabItem(
                  text: "Search",
                  icon: Icons.search,
                  textColor: Color(theme.thirdColor),
                  index: 0,
                  onPressed: _updateIndex,
                  theme: theme),
              buildTabItem(
                  text: "Recommend",
                  icon: Icons.star,
                  textColor: Color(theme.thirdColor),
                  index: 1,
                  onPressed: _updateIndex,
                  theme: theme),
              buildTabItem(
                  text: "Favorite",
                  icon: Icons.favorite,
                  textColor: Color(theme.thirdColor),
                  index: 2,
                  onPressed: _updateIndex,
                  theme: theme),
              buildTabItem(
                  text: "Me",
                  icon: Icons.person,
                  textColor: Color(theme.thirdColor),
                  index: 3,
                  onPressed: _updateIndex,
                  theme: theme),
            ],
          ),
        ),
      ),
      body: currentPage(),
    );
  }
}
