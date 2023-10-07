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
    const tabBarTitle = 'ListView';
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        border: Border.all(
          color: CupertinoColors.systemRed,
          width: 1.5,
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_list),
            label: tabBarTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.square_list),
            label: tabBarTitle,
          ),
        ],
      ),
      tabBuilder: (context, tabIndex) {
        return CupertinoTabView(
          builder: (context) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  CupertinoSliverNavigationBar(
                    largeTitle: const Text(tabBarTitle),
                    border: Border.all(
                      color: CupertinoColors.systemRed,
                      width: 1.5,
                    ),
                  )
                ];
              },
              body: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  return (notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent);
                },
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, itemIndex) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: CupertinoColors.systemRed,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
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
      builder: (context) {
        return CupertinoAlertDialog(
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
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
