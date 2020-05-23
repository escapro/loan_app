import 'package:Loan/NewLoan.dart';
import 'package:Loan/components/Components.dart';
// import 'package:Loan/components/MyButton.dart';
import 'package:flutter/material.dart';
import 'package:Loan/Home.dart';
import 'package:Loan/constans.dart';

class HomeScreen extends StatelessWidget {
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
        theme: ThemeData(
          primaryColor: Constans.PrimaryColor,
          accentColor: Constans.AccentColor,
        ),
        home: DefaultTabController(
            length: 3,
            initialIndex: 0,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Долги',
                    style: TextStyle(color: Constans.StdBlack)),
                elevation: 0.0,
                centerTitle: true,
                backgroundColor: Colors.white,
                bottom: _tabBar(),
                shape: Border(bottom: BorderSide(color: Constans.UltraLightGrey)),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add_circle,
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
              body: TabBarView(
                controller: _tabController,
                children: <Widget>[Home(page: 1), Home(page: 2), Home(page: 3)],
              ),
              floatingActionButton: Container(
                child: BottomButtons(oldContext: context),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            ))));
  }

  Widget _tabBar() {
    return (TabBar(
      controller: _tabController,
      indicatorWeight: 3,
      indicatorPadding: EdgeInsets.only(bottom: 1),
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Constans.PrimaryColor,
      unselectedLabelColor: Constans.Grey,
      tabs: <Widget>[
        Container(child: 
        Tab(child: Text("Все долги"))),
        Tab(child: Text("Взял в долг")),
        Tab(child: Text("Дал в долг"))
      ],
    ));
  }
}

class BottomButtons extends StatelessWidget {
  final oldContext;

  BottomButtons({Key key, @required this.oldContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20, top: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white.withOpacity(0),
            Colors.white.withOpacity(1)],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp
        )
      ),
      child: (Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(right: 20),
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
