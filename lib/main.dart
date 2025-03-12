import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wireguard_flutter/wireguard_flutter.dart';
import 'package:wireguard_vpn_demo/core/app_color.dart';
import 'package:wireguard_vpn_demo/splash_screen.dart';
import 'package:wireguard_vpn_demo/vpn_screen.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: kDebugMode && Platform.isWindows,
      builder: (_) => MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: AppColor.primary,
          scaffoldBackgroundColor: AppColor.bg,
          dialogBackgroundColor: AppColor.bg,
          colorScheme: ColorScheme.dark(
            primary: AppColor.primary,
          ),
        ),
        builder: DevicePreview.appBuilder,
        home:  const SplashScreen(),
        
      ),
    ),
  );
}