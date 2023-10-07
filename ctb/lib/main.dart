import 'package:flutter/cupertino.dart';

/// Flutter [CupertinoTabBar] app with a [ListView] inside a [NestedScrollView]
/// with [CupertinoSliverNavigationBar] support.

void main() => runApp(const CupertinoTabBarApp());

class CupertinoTabBarApp extends StatelessWidget {
  const CupertinoTabBarApp({super.key});

  @override
  Widget build(context) {
    return const CupertinoApp(
      home: CupertinoTabBarExample(),
    );
  }
}

class CupertinoTabBarExample extends StatelessWidget {
  const CupertinoTabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_list),
            label: 'List',
          ),
        ],
      ),
      tabBuilder: (context, tabIndex) {
        return CupertinoTabView(
          builder: (context) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  const CupertinoSliverNavigationBar(
                    largeTitle: Text('List'),
                  )
                ];
              },
              body: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  return (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent);
                },
                child: ListView.builder(
                  itemCount: 100,
                  itemBuilder: (context, itemIndex) {
                    return SizedBox(
                      width: _columnWidth(context),
                      child: CupertinoButton(
                        onPressed: () {
                          _showAlertDialog(
                            context,
                            'Tapped TabBarItem $tabIndex, ListVeiw item $itemIndex',
                          );
                        },
                        child: Text(
                          'TabBarItem $tabIndex, ListVeiw item $itemIndex',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showAlertDialog(BuildContext context, String message) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

double _columnWidth(context, {columns = 2}) {
  var mediaQueryData = MediaQuery.of(context);
  var width = Orientation.portrait == mediaQueryData.orientation
      ? mediaQueryData.size.shortestSide
      : mediaQueryData.size.longestSide;
  return width / columns;
}
