import 'package:flutter/material.dart';
import 'package:prohttp/provider/mainPro.dart';
import 'package:prohttp/utils/colors.dart';
import 'package:prohttp/utils/fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double returnScreenSize(BuildContext context, {@required bool height}) {
    if (height) {
      return MediaQuery.of(context).size.height;
    } else {
      return MediaQuery.of(context).size.width;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider and Http"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: returnScreenSize(context, height: true) * 0.04,
            ),
            Center(
                child: Text(
              "Select Genter",
              style: TextFonts.h1Text,
            )),
            SizedBox(
              height: returnScreenSize(context, height: true) * 0.02,
            ),
            // GENDER
            Selector<MainPro, Gender>(
              selector: (context, mainPro) => mainPro.gender,
              builder: (con, gender, _) {
                print("Build Gender");
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: returnScreenSize(context, height: false) * 0.05,
                    ),
                    //MALE
                    buildExpanded(context, () {
                      mainPro.changeGender(Gender.MALE);
                    }, "MALE", Gender.MALE == gender),
                    SizedBox(
                      width: returnScreenSize(context, height: false) * 0.05,
                    ),
                    buildExpanded(context, () {
                      mainPro.changeGender(Gender.FEMALE);
                    }, "Female", Gender.FEMALE == gender),
                    SizedBox(
                      width: returnScreenSize(context, height: false) * 0.05,
                    ),
                    buildExpanded(context, () {
                      mainPro.changeGender(Gender.NOTSAY);
                    }, "Prefer not to say", Gender.NOTSAY == gender),
                    SizedBox(
                      width: returnScreenSize(context, height: false) * 0.05,
                    ),
                  ],
                );
              },
            ),

            SizedBox(
              height: returnScreenSize(context, height: true) * 0.05,
            ),
            Center(
                child: Text(
              "Select Occupation",
              style: TextFonts.h1Text,
            )),
            SizedBox(
              height: returnScreenSize(context, height: true) * 0.02,
            ),

            Selector<MainPro, bool>(
                selector: (con, main) => main.isEmployed,
                builder: (context, isEmp, _) {
                  print("Build ouccupation");
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: returnScreenSize(context, height: false) * 0.05,
                      ),
                      buildExpanded(context, () {
                        mainPro.changeEmpy(true);
                      }, "Employed", isEmp),
                      SizedBox(
                        width: returnScreenSize(context, height: false) * 0.05,
                      ),
                      buildExpanded(context, () {
                        mainPro.changeEmpy(false);
                      }, "Unemployed", !isEmp),
                      SizedBox(
                        width: returnScreenSize(context, height: false) * 0.05,
                      ),
                    ],
                  );
                }),

            SizedBox(
              height: returnScreenSize(context, height: true) * 0.05,
            ),
            Center(
                child: Text(
              "Select Department",
              style: TextFonts.h1Text,
            )),
            SizedBox(
              height: returnScreenSize(context, height: true) * 0.02,
            ),

            Selector<MainPro, DEPART>(
                selector: (con, main) => main.depart,
                builder: (context, depart, _) {
                  print("Build department");
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: returnScreenSize(context, height: false) * 0.05,
                      ),
                      buildExpanded(context, () {
                        mainPro.changeDepartment(DEPART.DEV);
                      }, "Developer", DEPART.DEV == depart),
                      SizedBox(
                        width: returnScreenSize(context, height: false) * 0.05,
                      ),
                      buildExpanded(context, () {
                        mainPro.changeDepartment(DEPART.HR);
                      }, "HR", DEPART.HR == depart),
                      SizedBox(
                        width: returnScreenSize(context, height: false) * 0.05,
                      ),
                      buildExpanded(context, () {
                        mainPro.changeDepartment(DEPART.MANAGER);
                      }, "Manager", DEPART.MANAGER == depart),
                      SizedBox(
                        width: returnScreenSize(context, height: false) * 0.05,
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: returnScreenSize(context, height: false) * 0.10,
            ),
            Container(
              width: returnScreenSize(context, height: false) * 0.40,
              height: returnScreenSize(context, height: true) * 0.05,
              child: RaisedButton(
                color: AppColors.buttonColor,
                onPressed: () {
                  mainPro.getDogApi();
                },
                child: Text("Get a dog via http"),
              ),
            ),
            SizedBox(
              height: returnScreenSize(context, height: false) * 0.02,
            ),
            Container(
              width: double.infinity,
              height: returnScreenSize(context, height: true) * 0.30,
            )
          ],
        ),
      )),
    );
  }

  Expanded buildExpanded(
      BuildContext context, Function fun, String title, bool foo) {
    return Expanded(
      child: GestureDetector(
        onTap: fun,
        child: Container(
          height: returnScreenSize(context, height: true) * 0.05,
          alignment: Alignment.center,
          child: Text(
            "$title",
            style: TextFonts.subTitleText,
          ),
          decoration: BoxDecoration(
              color: foo ? AppColors.buttonColor : Colors.grey,
              borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}
