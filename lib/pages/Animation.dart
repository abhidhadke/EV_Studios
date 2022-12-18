import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class Animate extends StatefulWidget {
  const Animate({Key? key}) : super(key: key);

  @override
  State<Animate> createState() => _AnimateState();
}

class _AnimateState extends State<Animate> {
  bool _firstChild = false;
  bool isTapOn = false;
  @override
  Widget build(BuildContext context) {
    debugPrint('$isTapOn');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation"),
        centerTitle: true,
        backgroundColor: Colors.black45,
      ),
      backgroundColor: Colors.black26,
      body: Stack(
        children: [
          isTapOn ?  const WrapperScene(
            colors: [Colors.transparent],
            children: [
              RainDropWidget(
                rainConfig: RainConfig(
                    count: 20,
                    color: Colors.blue,
                    isRoundedEndsDrop: true,
                    areaXStart: 115,
                    areaXEnd: 114,
                    slideCurve: Curves.linear,
                    areaYStart: 170,
                    fallRangeMinDurMill: 20,
                    fallRangeMaxDurMill: 500,
                    lengthDrop: 20,
                    widthDrop: 15,
                    slideX: 0

                ),
              )
            ],) : Container(),
          AnimatedCrossFade(
              firstChild: GestureDetector(
                onTap: (){
                  _firstChild = !_firstChild;
                  debugPrint('tapped');
                  if(isTapOn){
                    return setState(() {
                      isTapOn = false;
                    });
                  }
                  else if(isTapOn == false){
                    return setState(() {
                      isTapOn = true;
                    });
                  }
                },
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/water-tap.png'),
                ),
              ),
              secondChild: GestureDetector(
                onTap: (){
                  _firstChild = !_firstChild;
                  debugPrint('tapped');
                  if(isTapOn){
                    return setState(() {
                      isTapOn = false;
                    });
                  }
                  else if(isTapOn == false){
                    return setState(() {
                      isTapOn = true;
                    });
                  }
                },
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/water-tap-off.png'),
                ),
              ),
              crossFadeState: _firstChild ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
          ),


        ],
      ),
    );
  }



}
