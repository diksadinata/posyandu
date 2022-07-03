import 'package:flutter/material.dart';
import 'package:posyandu/src/ui/formadd/form_add_screen.dart';
import 'package:posyandu/src/ui/home/home_screen.dart';

import 'model/profile.dart';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
        // ignore: deprecated_member_use
        accentColor: Colors.orangeAccent,
      ),
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: const Text(
            "Flutter CRUD API",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FormAddScreen(
                      profile: Profile(
                        id: '',
                        nama: "",
                        NIK: 0,
                        umur: 0,
                        berat_badan: 0,
                        lingkar_bokong: 0,
                        lingkar_lengan: 0,
                        lingkar_pinggang: 0,
                        tanggal_lahir: '',
                        tinggi_badan: 0,
                      ),
                    ),
                  ),
                );
                if (result != null) {
                  setState(() {});
                }
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        body: const HomeScreen(),
      ),
    );
  }
}
