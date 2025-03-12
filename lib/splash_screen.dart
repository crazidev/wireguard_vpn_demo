import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:wireguard_vpn_demo/vpn_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showFirst = true;
  bool hasAnimatedFirst = false;
  late AnimationController L7Controller;
  late AnimationController L6Controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: GestureDetector(
          onTap: () => setState(() {
            showFirst = !showFirst;
            hasAnimatedFirst = true;
          }),
          child: Stack(
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/MES—L7 2.png",
                    fit: BoxFit.contain,
                    width: MediaQuery.sizeOf(context).width,
                  ).slideDown(
                    from: 200,
                    curve: CustomSpringCurve(),
                    duration: Duration(milliseconds: 700),
                    animate: showFirst,
                    delay: Duration(milliseconds: 800),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Image.asset(
                      "assets/MES—L6 1.png",
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.sizeOf(context).width,
                    ),
                  ).slideDown(
                    from: 200,
                    curve: CustomSpringCurve(),
                    duration: Duration(milliseconds: 1000),
                    animate: showFirst,
                    delay: Duration(milliseconds: 800),
                  ),
                  Image.asset(
                    "assets/MES—L5 1.png",
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.sizeOf(context).width,
                  ).slideUp(
                    from: 1500,
                    curve: CustomSpringCurve(),
                    duration: Duration(milliseconds: 1000),
                    animate: showFirst,
                    delay: Duration(milliseconds: 800),
                  ),
                  Image.asset(
                    "assets/MES—L4 1.png",
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.sizeOf(context).width,
                  ).slideUp(
                    from: 1500,
                    curve: CustomSpringCurve(),
                    duration: Duration(milliseconds: 1000),
                    animate: showFirst,
                    delay: Duration(milliseconds: 800),
                  ),
                  Image.asset(
                    "assets/MES—L3 1.png",
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.sizeOf(context).width,
                  ).slideUp(
                    from: 1500,
                    curve: CustomSpringCurve(),
                    duration: Duration(milliseconds: 1000),
                    animate: showFirst,
                    delay: Duration(milliseconds: 800),
                  ),
                  Image.asset(
                    "assets/MES—L2 1.png",
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.sizeOf(context).width,
                  ).slideUp(
                    from: 1500,
                    curve: CustomSpringCurve(),
                    duration: Duration(milliseconds: 1000),
                    animate: showFirst,
                    delay: Duration(milliseconds: 800),
                  ),
                  Image.asset(
                    "assets/MES—L1 1.png",
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.sizeOf(context).width,
                  ).slideUp(
                    from: 1500,
                    curve: CustomSpringCurve(),
                    duration: Duration(milliseconds: 1000),
                    animate: showFirst,
                    delay: Duration(milliseconds: 800),
                  ),
                ],
              ),
              // if (!showFirst)
              ForestEntry(showFirst: showFirst),
              if (showFirst) ForestExit(showFirst: showFirst),
              Positioned(
                right: 0,
                left: 0,
                bottom: 10,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => VpnScreen())),
                  child: Image.asset(
                    'assets/connect_button.png',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ForestExit extends StatelessWidget {
  const ForestExit({
    super.key,
    required this.showFirst,
  });

  final bool showFirst;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/FOR—L7.png",
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ).slideDown(
          from: 200,
          curve: CustomSpringCurve(),
          duration: Duration(milliseconds: 800),
          delay: Duration(milliseconds: 800),
          animate: !showFirst,
        ),
        Image.asset(
          "assets/FOR—L6.png",
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ).slideUp(
          from: 1500,
          curve: CustomSpringCurve(),
          duration: Duration(milliseconds: 900),
          delay: Duration(milliseconds: 800),
          animate: !showFirst,
        ),
        Image.asset(
          "assets/FOR—L5.png",
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ).slideUp(
          from: 1500,
          curve: CustomSpringCurve(),
          duration: Duration(milliseconds: 800),
          delay: Duration(milliseconds: 800),
          animate: !showFirst,
        ),
        Image.asset(
          "assets/FOR—L4.png",
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ).slideUp(
          from: 1500,
          curve: CustomSpringCurve(),
          duration: Duration(milliseconds: 1000),
          delay: Duration(milliseconds: 900),
          animate: !showFirst,
        ),
        Image.asset(
          "assets/FOR—L3.png",
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ).slideUp(
          from: 1500,
          curve: CustomSpringCurve(),
          duration: Duration(milliseconds: 1000),
          delay: Duration(milliseconds: 800),
          animate: !showFirst,
        ),
        Image.asset(
          "assets/FOR—L2.png",
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ).slideUp(
          from: 1500,
          curve: CustomSpringCurve(),
          duration: Duration(milliseconds: 1000),
          delay: Duration(milliseconds: 800),
          animate: !showFirst,
        ),
        Image.asset(
          "assets/FOR—L1.png",
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ).slideUp(
          from: 1500,
          curve: CustomSpringCurve(),
          duration: Duration(milliseconds: 1300),
          delay: Duration(milliseconds: 1200),
          animate: !showFirst,
        ),
      ],
    );
  }
}

class ForestEntry extends StatelessWidget {
  const ForestEntry({
    super.key,
    required this.showFirst,
  });

  final bool showFirst;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/FOR—L7.png",
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ).slideDown(
          from: 200,
          curve: CustomSpringCurve(),
          duration: Duration(milliseconds: 1000),
          delay: Duration(milliseconds: 800),
          animate: !showFirst,
        ),
        Image.asset(
          "assets/FOR—L6.png",
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ).slideUp(
          from: 1500,
          curve: CustomSpringCurve(),
          duration: Duration(milliseconds: 1300),
          delay: Duration(milliseconds: 1100),
          animate: !showFirst,
        ),
        Image.asset(
          "assets/FOR—L5.png",
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ).slideUp(
          from: 1500,
          curve: CustomSpringCurve(),
          duration: Duration(milliseconds: 1200),
          delay: Duration(milliseconds: 1100),
          animate: !showFirst,
        ),
        Image.asset(
          "assets/FOR—L4.png",
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ).slideUp(
          from: 1500,
          curve: CustomSpringCurve(),
          duration: Duration(milliseconds: 1300),
          delay: Duration(milliseconds: 1000),
          animate: !showFirst,
        ),
        Image.asset(
          "assets/FOR—L3.png",
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ).slideUp(
          from: 1500,
          curve: CustomSpringCurve(),
          duration: Duration(milliseconds: 1100),
          delay: Duration(milliseconds: 1000),
          animate: !showFirst,
        ),
        Image.asset(
          "assets/FOR—L2.png",
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ).slideUp(
          from: 1500,
          curve: CustomSpringCurve(),
          duration: Duration(milliseconds: 1000),
          delay: Duration(milliseconds: 1000),
          animate: !showFirst,
        ),
        Image.asset(
          "assets/FOR—L1.png",
          fit: BoxFit.fitWidth,
          width: MediaQuery.sizeOf(context).width,
        ).slideUp(
          from: 1500,
          curve: CustomSpringCurve(),
          duration: Duration(milliseconds: 1300),
          delay: Duration(milliseconds: 800),
          animate: !showFirst,
        ),
      ],
    );
  }
}

class CustomSpringCurve extends Curve {
  final double mass;
  final double stiffness;
  final double damping;

  CustomSpringCurve(
      {this.mass = 0.01, this.stiffness = 0.24, this.damping = 0.09});

  @override
  double transform(double t) {
    if (t == 0.0) return 0.0;
    if (t == 1.0) return 1.0;

    final double omega_n = sqrt(stiffness / mass); // Natural frequency
    final double zeta = damping / (2 * sqrt(stiffness * mass)); // Damping ratio
    final double omega_d = omega_n * sqrt(1 - zeta * zeta); // Damped frequency

    // Compute the displacement over time, ensuring it starts at 0 and ends at 1
    double response = 1 - exp(-zeta * omega_n * t) * cos(omega_d * t);

    return response.clamp(0.0, 1.0); // Ensuring the output stays within [0,1]
  }
}
