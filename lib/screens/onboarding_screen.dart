import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bananas.jpg"), // First screen image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Fresh Groceries at Your Fingertips",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Get the best quality groceries delivered to your doorstep in minutes.",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                              color: Colors.green, shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/onboarding2');
                    },
                    child: const Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}