import 'package:ev_studios/pages/Animation.dart';
import 'package:ev_studios/pages/NightVision.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EV Studios'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Water Tap Animation'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Animate()));
              },
              style: ElevatedButton.styleFrom(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              child: const Text("Click Here"),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05,),
            const Text('Night Vision'),
            ElevatedButton(
              onPressed: () { 
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Nightvison()));
              },
              style: ElevatedButton.styleFrom(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),
              child: const Text("Click Here"),
            ),
          ],
        ),
      ),
    );
  }
}
