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
        home: VpnScreen(),
        // const SplashScreen(),
      ),
    ),
  );
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final wireguard = WireGuardFlutter.instance;
//   final WireguardService _wireguardService = WireguardService();
//   String _downloadCount = 'N/A';
//   String _uploadCount = 'N/A';
//   late String name;

//   @override
//   void initState() {
//     super.initState();
//     _getWireGuardDataCounts();
//     wireguard.vpnStageSnapshot.listen((event) {
//       debugPrint("status changed $event");
//       if (mounted) {
//         ScaffoldMessenger.of(context).clearSnackBars();
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text('status changed: $event'),
//         ));
//       }
//     });
//     name = 'my_wg_vpn';
//   }

//   Future<void> initialize() async {
//     try {
//       await wireguard.initialize(interfaceName: name);
//       debugPrint("initialize success $name");
//     } catch (error, stack) {
//       debugPrint("failed to initialize: $error\n$stack");
//     }
//   }

//   void _getWireGuardDataCounts() async {
//     try {
//       final dataCounts = await _wireguardService.getDataCounts();
//       setState(() {
//         _downloadCount = dataCounts['download'].toString();
//         _uploadCount = dataCounts['upload'].toString();
//       });
//     } catch (e) {
//       print('Failed to get data counts: $e');
//     }
//   }

//   void startVpn() async {
//     try {
//       await wireguard.startVpn(
//         serverAddress: '167.235.55.239:51820',
//         wgQuickConfig: conf,
//         providerBundleIdentifier: 'com.billion.wireguardvpn.WGExtension',
//       );
//     } catch (error, stack) {
//       debugPrint("failed to start $error\n$stack");
//     }
//   }

//   void disconnect() async {
//     try {
//       await wireguard.stopVpn();
//     } catch (e, str) {
//       debugPrint('Failed to disconnect $e\n$str');
//     }
//   }

//   void getStatus() async {
//     debugPrint("getting stage");
//     final stage = await wireguard.stage();
//     debugPrint("stage: $stage");

//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('stage: $stage'),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints.expand(),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(height: 20),
//           TextButton(
//             onPressed: initialize,
//             style: ButtonStyle(
//                 minimumSize: WidgetStateProperty.all<Size>(const Size(100, 50)),
//                 padding: WidgetStateProperty.all(
//                     const EdgeInsets.fromLTRB(20, 15, 20, 15)),
//                 backgroundColor:
//                     WidgetStateProperty.all<Color>(Colors.blueAccent),
//                 overlayColor: MaterialStateProperty.all<Color>(
//                     Colors.white.withOpacity(0.1))),
//             child: const Text(
//               'initialize',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextButton(
//             onPressed: startVpn,
//             style: ButtonStyle(
//                 minimumSize:
//                     MaterialStateProperty.all<Size>(const Size(100, 50)),
//                 padding: MaterialStateProperty.all(
//                     const EdgeInsets.fromLTRB(20, 15, 20, 15)),
//                 backgroundColor:
//                     MaterialStateProperty.all<Color>(Colors.blueAccent),
//                 overlayColor: MaterialStateProperty.all<Color>(
//                     Colors.white.withOpacity(0.1))),
//             child: const Text(
//               'Connect',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextButton(
//             onPressed: disconnect,
//             style: ButtonStyle(
//                 minimumSize: WidgetStateProperty.all<Size>(const Size(100, 50)),
//                 padding: WidgetStateProperty.all(
//                     const EdgeInsets.fromLTRB(20, 15, 20, 15)),
//                 backgroundColor:
//                     WidgetStateProperty.all<Color>(Colors.blueAccent),
//                 overlayColor: WidgetStateProperty.all<Color>(
//                     Colors.white.withOpacity(0.1))),
//             child: const Text(
//               'Disconnect',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           const SizedBox(height: 20),
//           TextButton(
//             onPressed: getStatus,
//             style: ButtonStyle(
//                 minimumSize: WidgetStateProperty.all<Size>(const Size(100, 50)),
//                 padding: WidgetStateProperty.all(
//                     const EdgeInsets.fromLTRB(20, 15, 20, 15)),
//                 backgroundColor:
//                     WidgetStateProperty.all<Color>(Colors.blueAccent),
//                 overlayColor: WidgetStateProperty.all<Color>(
//                     Colors.white.withOpacity(0.1))),
//             child: const Text(
//               'Get status',
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text('Download: $_downloadCount'),
//               Text('Upload: $_uploadCount'),
//               ElevatedButton(
//                 onPressed: _getWireGuardDataCounts,
//                 child: const Text('Refresh Data Counts'),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// const String conf = '''[Interface]
// Address = 192.168.6.33/32
// DNS = 1.1.1.1,8.8.8.8
// PrivateKey = ePlSprKx3E/YcXnYBzU9dZ1e8GYX2GUKMdl023sWzWg=
// [Peer]
// publickey=BvKWHoBImVpLNmKCiFI/kot5FsCapXX67rnHlG9y8Aw=
// AllowedIPs = 0.0.0.0/0, ::/0
// Endpoint = br1.vpnjantit.com:443
// ''';

// class WireguardService {
//   static const platform =
//       MethodChannel('billion.group.wireguard_flutter/wgcontrol');

//   Future<Map<String, int>> getDataCounts() async {
//     try {
//       final Map<dynamic, dynamic> result =
//           await platform.invokeMethod('getDataCounts');
//       return Map<String, int>.from(result);
//     } catch (e) {
//       throw 'Failed to get data counts: $e';
//     }
//   }
// }
