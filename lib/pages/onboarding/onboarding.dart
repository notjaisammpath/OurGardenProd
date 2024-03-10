import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_walkthrough/backend/back4app.dart';
import 'package:flutter_walkthrough/pages/home.dart';
import 'package:flutter_walkthrough/pages/onboarding/signup.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerEmail = TextEditingController();
  bool pageComplete = true;
  PageController pageController = PageController();
  bool alreadyUser = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset('assets/images/ourgarden_logo.jpg'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(onPressed: () {
              setState(() {
                alreadyUser = !alreadyUser;
              });
              }, child: 
            alreadyUser? Text("Signup instead", style: Theme.of(context).textTheme.displaySmall) : Text("Login instead", style: Theme.of(context).textTheme.displaySmall),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              controller: controllerUsername,
              enabled: !Back4app().isLoggedIn,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Username'),
            ),
            const SizedBox(
              height: 8,
            ),
            if(!alreadyUser)
            TextField(
              controller: controllerEmail,
              enabled: !Back4app().isLoggedIn,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Email'),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: controllerPassword,
              enabled: !Back4app().isLoggedIn,
              obscureText: true,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  labelText: 'Password'),
            ),
            const SizedBox(
              height: 16,
            ),
            if(!alreadyUser)
            SizedBox(
              height: 50,
              child: TextButton(
                  onPressed: Back4app().isLoggedIn
                      ? null
                      : () => {
                            Back4app().doUserRegistration(
                              controllerUsername.text.trim(),
                              controllerEmail.text.trim(),
                              controllerPassword.text.trim(),
                              context,
                            ),
                            setState(() {
                              Back4app().isLoggedIn
                                  ? Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Signup()),
                                      (route) => false)
                                  : null;
                            })
                          },
                  child: Text(
                    'Signup',
                    style: Theme.of(context).textTheme.displaySmall,
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            if(alreadyUser)
            SizedBox(
              height: 50,
              child: TextButton(
                  onPressed: Back4app().isLoggedIn
                      ? null
                      : () => {
                            Back4app().doUserLogin(
                                controllerUsername.text.trim(),
                                controllerPassword.text.trim(),
                                context),
                            setState(() {
                              Back4app().isLoggedIn
                                  ? Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home(
                                                startIndex: 0,
                                              )),
                                      (route) => false)
                                  : null;
                            })
                          },
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.displaySmall,
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            
          ],
        ),
      ),
    ));
  }
}
