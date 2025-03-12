List<Server> servers = [
  Server(
    conf: '''[Interface]
Address = 192.168.6.248/32
DNS = 1.1.1.1,8.8.8.8
PrivateKey = 8Kf7tIZEWx41l8GQTuKm0LO3uBguehHHCMYGzNJsRGI=
[Peer]
publickey=zwBItQRGuJze84z4Gv/27O/Xq4CIA0BBCRLWiEXnwC4=
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = uk.vpnjantit.com:1024
''',
    country: 'United Kingdom',
    city: 'London',
    countryFlag: 'https://www.vpnjantit.com/assets/bendera/united-kingdom.svg',
    host: '',
  ),
  Server(
    conf: '''[Interface]
Address = 192.168.6.167/32
DNS = 1.1.1.1,8.8.8.8
PrivateKey = QPOynP2KiG1p+ee8ymvPu/OCwBzOdU7jpQLXmjv1w1c=
[Peer]
publickey=h1Qr9B2JHc+S/c3l8rP8PbR01ZUOe4nCY7Smf4BHank=
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = usa2.vpnjantit.com:1024
''',
    country: 'United States',
    city: 'Miami',
    countryFlag: 'https://www.vpnjantit.com/assets/bendera/united-states.svg',
    host: '',
  ),
  Server(
    conf: '''[Interface]
Address = 192.168.6.138/32
DNS = 1.1.1.1,8.8.8.8
PrivateKey = aBoXCDZJeh4fr8hsHhn9xj0dx1W4dyXZ0bKgErontWM=
[Peer]
publickey=GYK3CLamipPxbSJu+0o5zOl5FrvukBTq2PaZ/c7bAnE=
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = fr4.vpnjantit.com:1024
''',
    country: 'France',
    city: 'Paris',
    countryFlag: 'https://www.vpnjantit.com/assets/bendera/france.svg',
    host: '',
  ),
];

class Server {
  final String conf;
  final String host;
  final String country;
  final String city;
  final String countryFlag;

  Server({
    required this.conf,
    required this.host,
    required this.country,
    required this.city,
    required this.countryFlag,
  });
}
