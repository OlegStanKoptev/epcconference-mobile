part of '../home.dart';

class HomeFeed extends StatelessWidget {
  Route<T> getRoute<T>() {
    return buildRoute<T>(
      '/home/feed',
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage('assets/images/home_background.png'),
            fit: BoxFit.fitWidth),
      ),
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    textStyle: TextStyle(fontSize: 16),
                    fixedSize: Size(100, 80),
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                onPressed: () {},
                child: Text(
                  'Agenda',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    textStyle: TextStyle(fontSize: 16),
                    fixedSize: Size(100, 80),
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                onPressed: () {},
                child: Text(
                  'Speaker',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    textStyle: TextStyle(fontSize: 15),
                    fixedSize: Size(100, 80),
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                onPressed: () {},
                child: Text(
                  'Attendees',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}