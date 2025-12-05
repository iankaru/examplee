import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:example/common/header.dart';
import 'get_location.dart'; // Kui sul on asukoha fail, muidu eemalda see

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<StatefulWidget> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();

    // Pärime asukoha ja saadame API-sse
    getLocation().then((position) {
      debugPrint(position.toString());
      _load(position.latitude.toString(), position.longitude.toString());
    });
  }

  // API päring
  void _load(String lat, String lon) async {
    await http
        .get(
          Uri.https('api.met.no', 'weatherapi/locationforecast/2.0/compact', {
            'lat': lat,
            'lon': lon,
          }),
          headers: {'User-Agent': 'MyApp/1.0 (ianerickaru@gmail.com)'},
        )
        .then((response) {
          debugPrint(response.body); // Näitab ilmainfot
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(title: 'Tere tulemast!'),
      body: const Center(child: Text("Laen ilmaandmeid...")),
    );
  }
}
