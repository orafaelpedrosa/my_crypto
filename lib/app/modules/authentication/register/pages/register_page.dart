import 'package:flutter/material.dart';
import 'package:mycrypto/app/modules/authentication/register/pages/widgets/first_form_register_widget.dart';
import 'package:mycrypto/app/modules/authentication/register/pages/widgets/second_form_register_widget.dart';

class RegisterPage extends StatefulWidget {
  final String title;
  const RegisterPage({Key? key, this.title = 'RegisterPage'}) : super(key: key);
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final PageController pageController = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cadastre-se',
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.white,
              ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              if (currentPage > 0) {
                pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              } else {
                Navigator.of(context).pop();
              }
            }),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                onPageChanged: (index) {
                  currentPage = index;
                },
                children: [
                  FirstFormRegisterWidget(
                    pageController: pageController,
                  ),
                  SecondFormRegisterWidget(
                    pageController: pageController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
