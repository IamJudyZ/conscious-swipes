import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conscious Swipes',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Swipe Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 2;

  bool show = true;

  Person user1;
  Person user2;
  Person user3;
  Person user4;
  Person user5;
  Person user6;
  List<Person> people;
  List<Person> userMatchedWith;
  List<Person> matchedWithUser;

  _MyHomePageState() {
    user1 = Person('user1.jpg', 'Sarah', 'vegan', 'democrat', 'education',
        'I like to talk to people!');
    user2 = Person('user2.jpg', 'Jacob', 'christian', 'sustainability',
        'democrat', 'Get to know me!');
    user3 = Person('user3.jpg', 'Tom', 'republican', 'pro-life', 'education',
        'Swipe right if you want to have a nice chat!');
    user4 = Person('user1.jpg', 'Annie', 'healthcare', '2020 elections',
        'education', 'Looking for a good conversation!');
    user5 = Person('user2.jpg', 'Markus', 'christian', 'sustainability',
        'vegan', 'Just chattin');
    user6 = Person('user3.jpg', 'David', 'republican', 'pro-life', 'AI ethics',
        'Covid has not helped my social life');
    people = [user1, user2, user3, user4, user5, user6];
    userMatchedWith = [];
    matchedWithUser = [];
  }

   void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    CardController controller;

    Column match = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("You and ${user6.name} were a match!",
            style: TextStyle(fontSize: 25)),
        Text("Chat with them at zoom.com/xyz", style: TextStyle(fontSize: 25)),
        FlatButton(
          child: Text(
            'Cancel',
            style: TextStyle(fontSize: 20.0),
          ),
          color: Colors.green,
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              show = false;
            });
          }, //change this to make it go to next card
        ),
      ],
    );

    Container swipe = Container(
      height: MediaQuery.of(context).size.height * 2,
      child: Stack(
        children: <Widget>[
          new Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("You've reached the end."),
                  Text("Come back later to see more suggestions!")
                ],
              ),
            ),
          ),
          if (show)
            Card(
              child: Center(child: match),
            ),
          new TinderSwapCard(
            swipeUp: true,
            swipeDown: true,
            orientation: AmassOrientation.BOTTOM,
            totalNum: people.length,
            swipeEdge: 5.0,
            maxWidth: MediaQuery.of(context).size.width * 1,
            maxHeight: MediaQuery.of(context).size.width * 3,
            minWidth: MediaQuery.of(context).size.width * 0.95,
            minHeight: MediaQuery.of(context).size.width * 0.95,
            cardBuilder: (context, index) => Card(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Image.asset('${people[index].image}'),
                      Column(
                        children: [
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: people[index].name,
                                      style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ]
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(people[index].bioText),
                            ],
                          ),
                          Row(
                            children: [
                              Chip(label: Text(people[index].tag1)),
                              Chip(label: Text(people[index].tag2)),
                              Chip(label: Text(people[index].tag3)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              cardController: controller = CardController(),
              swipeUpdateCallback:
                (DragUpdateDetails details, Alignment align) {
                /// Get swiping card's alignment
                if (align.x < 0) {
                } else if (align.x > 0) {}
              },
              swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
                  if (orientation == CardSwipeOrientation.RIGHT) {
                    if (!user.userMatchedWith.contains(people[index])) {
                      user.userMatchedWith.add(people[index]);
                    }
                  } else {
                    user.userMatchedWith.remove(people[index]);
                  }
                  setState(() {
                    people.removeAt(index);
                  });
                },
          ),
        ],
      ),
    );
    List<Widget> _pages = <Widget>[
      Container(
        margin: EdgeInsets.all(100.0),
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: user.userMatchedWith.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Container(
                height: 50,
                color: Colors.amber[300],
                child:
                    Center(child: Text('${user.userMatchedWith[index].name}')),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MatchInfo(user.userMatchedWith[index].name)),
                );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
      Center(child: swipe),
      Card( /////////////////////////////////////////////////////////////////////////////////////
        child: Container(
          padding: const EdgeInsets.only(bottom: 20, top: 20, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.asset('${user.image}'),
              Column(
                children: [
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: user.name,
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ]
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(user.bioText),
                    ],
                  ),
                  Row(
                    children: [
                      Chip(label: Text(user.tag1)),
                      Chip(label: Text(user.tag2)),
                      Chip(label: Text(user.tag3)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),  
    //     alignment: Alignment.center,
    //     children: <Widget>[
    //       Column(
    //         children: <Widget>[
    //           Container(
    //             height: 200.0,
    //             color: Colors.orange,
    //             child: Center(
    //               child: Image.asset('user1.jpg'),
    //             ),
    //           ),
    //           Expanded(
    //             child: Container(
    //               color: Colors.white,
    //               child: Center(
    //                 child: Text('Introduction here'),
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //       // Profile image
    //       Positioned(
    //         top: 150.0,
    //         child: Container(
    //           height: 100.0,
    //           width: 100.0,
    //           decoration:
    //               BoxDecoration(shape: BoxShape.circle, color: Colors.green),
    //         ),
    //       )
    //     ],
    //   )
    ];

    return new Scaffold(
      body: SafeArea(child: new Center(child: _pages.elementAt(_selectedIndex))),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward),
            label: 'Swipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onNavTapped,
      ),
    );
  }
}

class MatchInfo extends StatelessWidget {
  @override
  String _matcher;
  MatchInfo(this._matcher);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("You are Matched!"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("You and $_matcher were a match!",
                style: TextStyle(fontSize: 25)),
            Text("Chat with them at zoom.com/xyz!",
                style: TextStyle(fontSize: 25)),
            
          ],
        ),
      ),
    );
  }
}

class Person {
  var image;
  String name;
  String tag1;
  String tag2;
  String tag3;
  String bioText;
  List<Person> userMatchedWith = [];

  Person(this.image, this.name, this.tag1, this.tag2, this.tag3,
      this.bioText); //constructor
}

Person user = new Person('Jason.jpg', 'Jason', '', '', '', '');
