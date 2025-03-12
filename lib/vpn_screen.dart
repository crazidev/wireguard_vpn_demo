import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:wireguard_flutter/wireguard_flutter.dart';
import 'package:wireguard_vpn_demo/components/stat_container.dart';
import 'package:wireguard_vpn_demo/core/app_color.dart';
import 'package:wireguard_vpn_demo/servers.dart';
import 'package:http/http.dart' as http;

class VpnScreen extends StatefulWidget {
  const VpnScreen({super.key});

  @override
  State<VpnScreen> createState() => _VpnScreenState();
}

class _VpnScreenState extends State<VpnScreen> {
  final wireguard = WireGuardFlutter.instance;
  final WireguardService _wireguardService = WireguardService();
  VpnStage status = VpnStage.preparing;
  String _downloadCount = 'N/A';
  String _uploadCount = 'N/A';
  late String name;
  String? ipAddress;
  Server selectedServer = servers.first;

  @override
  void initState() {
    super.initState();

    _getWireGuardDataCounts();
    wireguard.vpnStageSnapshot.listen((event) {
      if (event == VpnStage.connected) {
        getPublicIp();
      } else {
        ipAddress = null;
      }

      setState(() {
        status = event;
      });
    });
    name = 'my_wg_vpn';
    initialize();
  }

  Future<void> initialize() async {
    try {
      await wireguard.initialize(interfaceName: name);
      debugPrint("initialize success $name");
    } catch (error, stack) {
      debugPrint("failed to initialize: $error\n$stack");
    }
  }

  void _getWireGuardDataCounts() async {
    try {
      final dataCounts = await _wireguardService.getDataCounts();
      setState(() {
        _downloadCount = dataCounts['download'].toString();
        _uploadCount = dataCounts['upload'].toString();
      });
    } catch (e) {
      print('Failed to get data counts: $e');
    }
  }

  void startVpn() async {
    try {
      await wireguard.startVpn(
        serverAddress: '167.235.55.239:51820',
        wgQuickConfig: selectedServer.conf,
        providerBundleIdentifier: 'com.billion.wireguardvpn.WGExtension',
      );
    } catch (error, stack) {
      debugPrint("failed to start $error\n$stack");
    }
  }

  Future<void> getPublicIp() async {
    final response =
        await http.get(Uri.parse('https://api64.ipify.org?format=json'));
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      setState(() {
        ipAddress = res['ip'];
      });
      print('Public IP: ${res}');
    } else {
      print('Failed to get public IP');
    }
  }

  void disconnect() async {
    try {
      await wireguard.stopVpn();
    } catch (e, str) {
      debugPrint('Failed to disconnect $e\n$str');
    }
  }

  void getStatus() async {
    debugPrint("getting stage");
    final stage = await wireguard.stage();
    debugPrint("stage: $stage");

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('stage: $stage'),
      ));
    }
  }

  void changeServer(Server server) {}
  @override
  Widget build(BuildContext context) {
    var color = switch (status) {
      VpnStage.connected => Colors.green,
      VpnStage.connecting => Colors.yellow,
      _ => Colors.grey
    };
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Stack(children: [
          Positioned(
            top: 0,
            child: Image.asset(
              'assets/Vector_2646.jpg',
              fit: BoxFit.fitHeight,
              opacity: AlwaysStoppedAnimation(0.3),
              width: 1500,
            ),
          ),
          SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Text(
                    "WireGuard",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.primary,
                        ),
                  ),
                  Text(
                    "VPN",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Icon(
                  status == VpnStage.connected
                      ? Ionicons.shield_checkmark
                      : Ionicons.shield,
                  color: color),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Text(
                    status.name.toString().capitalizeFirst(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                  ),
                ],
              ),
              if (ipAddress != null && status == VpnStage.connected) ...[
                SizedBox(height: 20),
                Text(
                  "IP Address: ${ipAddress}",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
              SizedBox(height: 150),
              AvatarGlow(
                duration: Duration(milliseconds: 2000),
                glowColor: switch (status) {
                  VpnStage.connected => Colors.green,
                  _ => Colors.grey
                },
                animate: status == VpnStage.connected,
                repeat: true,
                glowRadiusFactor: 0.5,
                glowShape: BoxShape.circle,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: InkWell(
                        onTap: () {
                          if (status == VpnStage.connected) {
                            disconnect();
                          } else {
                            startVpn();
                          }
                        },
                        borderRadius: BorderRadius.circular(200),
                        child: Container(
                          width: 130,
                          height: 130,
                          color: AppColor.container.withOpacity(.8),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              if (status == VpnStage.connecting ||
                                  status == VpnStage.disconnecting)
                                CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.yellow,
                                ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.power_settings_new_sharp,
                                    color: status == VpnStage.connected
                                        ? Colors.green
                                        : null,
                                    size: 50,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: AppColor.bottomNavBG,
                    builder: (_) => ServerListBottomsheet(
                      selected: selectedServer,
                      onTap: (Server selected) {
                        Navigator.pop(context);
                        setState(() {
                          selectedServer = selected;
                        });
                        disconnect();
                        startVpn();
                      },
                    ),
                  );
                },
                child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.container.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 3,
                    ),
                    child: Column(children: [
                      ListTile(
                        leading: SvgPicture.network(
                          selectedServer.countryFlag,
                          width: 50,
                        ),
                        title: Text(
                          selectedServer.country,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primary),
                        ),
                        subtitle: Text(selectedServer.city),
                        trailing: Icon(
                          Icons.chevron_right,
                          size: 30,
                        ),
                      )
                    ])),
              ),
              SizedBox(height: 30),
              Row(
                spacing: 20,
                children: [
                  StatsContainer(
                    icon: SimpleLineIcons.cloud_download,
                    title: 'Download',
                    value: "0",
                    subtitle: "kb/s",
                  ),
                  StatsContainer(
                    icon: SimpleLineIcons.cloud_upload,
                    title: 'Upload',
                    value: "0",
                    subtitle: "kb/s",
                  ),
                ],
              ),
              SizedBox(height: 30),
            ]),
          ))
        ]),
      ),
    );
  }
}

class ServerListBottomsheet extends StatelessWidget {
  const ServerListBottomsheet({
    super.key,
    required this.selected,
    required this.onTap,
  });

  final Server selected;
  final Function(Server selected) onTap;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                "Select VPN Server",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 10),
              ListView.separated(
                itemCount: servers.length,
                shrinkWrap: true,
                separatorBuilder: (_, i) => Divider(
                  color: Colors.grey.withOpacity(0.3),
                ),
                itemBuilder: (_, index) {
                  var server = servers[index];
                  return ListTile(
                    onTap: () => onTap(server),
                    selected: server.country == selected.country,
                    leading: SvgPicture.network(
                      server.countryFlag,
                      width: 50,
                    ),
                    title: Text(
                      server.country,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(server.city),
                    trailing: Icon(
                      Icons.chevron_right,
                      size: 30,
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class WireguardService {
  static const platform =
      MethodChannel('billion.group.wireguard_flutter/wgcontrol');

  Future<Map<String, int>> getDataCounts() async {
    try {
      final Map<dynamic, dynamic> result =
          await platform.invokeMethod('getDataCounts');
      return Map<String, int>.from(result);
    } catch (e) {
      throw 'Failed to get data counts: $e';
    }
  }
}

extension StringExtension on String {
  /// Capitalizes the first letter of the string.
  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}
