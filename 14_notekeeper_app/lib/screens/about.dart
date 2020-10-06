import 'package:ant_icons/ant_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:notekeeperapp/utils/theme_changer.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:expanding_bottom_bar/expanding_bottom_bar.dart';


class AboutApp extends StatelessWidget {
  final int index=0;
  final List <Color> colorList =[Colors.blue,Colors.red,Colors.green,Colors.deepPurple,Colors.yellow];
  @override

  Widget build(BuildContext context) {
    int index =0;
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            buildCardWidget(Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Text('About app'.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                fontSize: 20,
                fontWeight: FontWeight.bold),),
                SizedBox(height: 30,),
                Center(
                  child: Text('Developed by'.toUpperCase(),
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1)),
                ),
                SizedBox(height: 15,),
                Center(
                  child: Text('razorcalhn'.toLowerCase(),
                      style: TextStyle(
                        fontSize: 25,
                          color: Colors.black54,
                          fontFamily: 'JosefinSans',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1)),
                ),
                SizedBox(height: 35,),
                Center(child: Text('Source code',style: TextStyle(color: Colors.black54,
                letterSpacing: 1),)),
                Center(
                    child:MaterialButton(
                      color: Colors.white60,
                      child: Container(
                        width: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children : <Widget>[Icon(
                            Icons.link
                          ),
                            Text('Github')]),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)
                      ),
                      onPressed: (){
                        launch('https://github.com/razorcalhn/notekeeper_app');
                      },
                    ) )


              ],
            )),
            buildCardWidget(Center(
              child: Column(
                children: <Widget>[
                  Text('made with'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5
                  ),),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/flutter.png'),
                        width: 100,height: 50,
                      ),
                      Icon(
                        Icons.add,
                        size: 25,
                      ),
                      Image(
                        image: AssetImage('assets/dart.png'),
                        width: 100,height: 50,
                      ),
                    ],
                  ),

                ],
              ),
            ))

          ],
        ),
      ),

      bottomNavigationBar: ExpandingBottomBar(
          navBarHeight: 90,
          items:  [
        ExpandingBottomBarItem(
            text: 'select\ntheme',
            icon: AntIcons.font_colors,
            selectedColor: Colors.blueAccent,),
        ExpandingBottomBarItem(
          text: 'Red',
            icon: AntIcons.font_colors,
            selectedColor: Colors.red,),
        ExpandingBottomBarItem(
          text: 'Green',
            icon: AntIcons.font_colors,
            selectedColor: Colors.green,),
        ExpandingBottomBarItem(
          text: 'Purple',
              icon: AntIcons.font_colors,
              selectedColor: Colors.deepPurpleAccent,),
        ExpandingBottomBarItem(
          text: 'Yellow',
              icon: AntIcons.font_colors,
              selectedColor: Colors.yellow,)
          ],
          selectedIndex: index,
          onIndexChanged: (demo) {
            index = demo;
            setThemeToSP(demo);
            _themeChanger.setTheme(ThemeData(primarySwatch:colorList[demo]));
            Navigator.pop(context);
          }) ,
    );
  }
}


//widget for returning cards for about-app

Widget buildCardWidget(Widget child) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              offset: Offset(0,20),
              color: Colors.black.withAlpha(30),
              blurRadius: 10)
        ]),
    margin: EdgeInsets.all(24),
    padding: EdgeInsets.fromLTRB(16,0,16,16),
    child: child,
  );

}
