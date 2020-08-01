import 'package:covid_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ AppColors.red, AppColors.white, AppColors.white, AppColors.grey],
            stops: [0.75, 0.75, 1, 1]
          )
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 85),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text('Made by Nghia',
                      style: TextStyle(color: AppColors.white)),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text('Covid-19\nPandemic Report',
                      style: GoogleFonts.lato(
                        textStyle: Theme.of(context).textTheme.bodyText1,
                        color: AppColors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.2,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
          width: 250,
          child: FloatingActionButton.extended(
            backgroundColor: AppColors.white,
            onPressed: () {},
            label: Row(
              children: [
                Container(
                  width: 200,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter country'
                    ),
                  ),
                ),
                Image.asset(AppImages.icSearch),
              ],
            ))),
    );
  }
}

