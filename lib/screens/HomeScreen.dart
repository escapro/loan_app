import 'package:Loan/NewLoan.dart';
import 'package:Loan/components/Components.dart';
import 'package:flutter/material.dart';
import 'package:Loan/Home.dart';
import 'package:Loan/constans.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class HomeScreen extends StatelessWidget {
  TabController _tabController;
  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Constans.PrimaryColor,
          accentColor: Constans.AccentColor,
          splashColor: Colors.transparent,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate, // ONLY if it's a RTL language
        ],
        supportedLocales: const [
          Locale('ru', 'RU'), // include country code too
        ],
        home: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Scaffold(
              body: SafeArea(
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverAppBar(
                        title: const Text('Мои долги',
                            style: const TextStyle(color: Constans.StdBlack)),
                        elevation: 0.0,
                        // centerTitle: true,
                        backgroundColor: Colors.white,
                        pinned: true,
                        floating: true,
                        snap: true,
                        bottom: _tabBar(),
                        shape: const Border(
                            bottom: const BorderSide(color: Constans.UltraLightGrey)),
                        actions: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.add_circle,
                                size: 30, color: Constans.PrimaryColor),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (oldContext) => NewLoan(
                                          action: 1,
                                        )),
                              );
                            },
                          ),
                        ],
                      ),
                    ];
                  },
                  body: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      Home(page: 1),
                      Home(page: 2),
                      Home(page: 3)
                    ],
                  ),
                ),
              ),
              floatingActionButton: Container(
                child: const BottomButtons(),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ))));
  }

  Widget _tabBar() {
    return (const TabBar(
      indicatorWeight: 3,
      indicatorPadding: const EdgeInsets.only(bottom: 1),
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Constans.PrimaryColor,
      unselectedLabelColor: Constans.Grey,
      tabs: const <Widget>[
        const Tab(child: const Text("Все долги")),
        const Tab(child: const Text("Взял в долг")),
        const Tab(child: const Text("Дал в долг"))
      ],
    ));
  }
}

class BottomButtons extends StatelessWidget {

  const BottomButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, top: 10),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0),
                Colors.white.withOpacity(1)
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp)),
      child: (Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(right: 20),
              child: MyButton(
                text: "Взял в долг",
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (oldContext) => NewLoan(
                              action: 1,
                            )),
                  )
                },
              )),
          Container(
            child: MyButton(
              text: "Дал в долг",
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (oldContext) => NewLoan(
                            action: 2,
                          )),
                )
              },
            ),
          ),
        ],
      )),
    );
  }
}
