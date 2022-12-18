import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:weekday_selector/weekday_selector.dart';

class Nightvison extends StatefulWidget {
  const Nightvison({Key? key}) : super(key: key);

  @override
  State<Nightvison> createState() => _NightvisonState();
}

class _NightvisonState extends State<Nightvison> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
   bool nightMode = false;
   bool scheduleNight = false;
   bool autoMode = false;
   List<String> timeFormat = ['AM', 'PM'];
    String startTime = 'Not Set';
    String endTime = 'Not Set';
  List<bool?> values = List.filled(7, false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Colors.white,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width*0.9,
        child: FloatingActionButton.extended(
          onPressed: (){
            final snackBar = SnackBar(
                content: const Center(child: Text('Saved', style: TextStyle(color: Colors.black),)),
              backgroundColor: Colors.white70,
              elevation: 2,
              width: MediaQuery.of(context).size.width*0.2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              behavior: SnackBarBehavior.floating,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          label: const Text('Save'),
          backgroundColor: Colors.green[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _widgetCard(ListTile(
              title: const Text('Night Vision Mode', style: TextStyle(fontWeight: FontWeight.bold),),
              trailing: Switch(
                value: nightMode,
                onChanged: _nightMode,
                activeColor: Colors.white,
                activeTrackColor: Colors.green[700],
              ),
            )),
            const SizedBox(height: 30,),
            _widgetCard( Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Schedule night mode', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                      Switch(
                        value: scheduleNight,
                        onChanged: _scheduleNight,
                        activeColor: Colors.white,
                        activeTrackColor: Colors.green[700],
                      ),
                    ],
                  ),
                  const Text('Start Time', style: TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 10,bottom: 10, right: 10),
                    height: 50,
                    width: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            _showTime(context, true);
                          },
                          child: Center(child: Text(startTime, style: const TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                        const SizedBox(width: 30,),
                        Row(
                          children: [
                            SizedBox(
                              width: 29,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.end,
                                autofocus: false,
                                controller: _controller1,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                decoration: const InputDecoration(
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                icon: const Icon(Icons.arrow_drop_down_rounded),
                                  isDense: true,
                                  items: timeFormat.map<DropdownMenuItem<String>>((String value){
                                    return DropdownMenuItem(
                                        value: value,
                                        child: Text(value));
                                  }).toList(),
                                  elevation: 4,
                                  onChanged: (String? value){
                                    _controller1.text = value!;
                                  }),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('End Time', style: TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold),),
                  const SizedBox(height: 10,),
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 10,bottom: 10, right: 10),
                    height: 50,
                    width: 190,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            _showTime(context, false);
                          },
                          child: Text(endTime, style: const TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        const SizedBox(width: 30,),
                        Row(
                          children: [
                            SizedBox(
                              width: 30,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.end,
                                autofocus: false,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                controller: _controller2,
                                decoration: const InputDecoration(
                                    border: InputBorder.none
                                ),
                              ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isDense: true,
                                  icon: const Icon(Icons.arrow_drop_down_rounded),
                                  items: timeFormat.map<DropdownMenuItem<String>>((String value){
                                    return DropdownMenuItem(
                                        value: value,
                                        child: Text(value));
                                  }).toList(),
                                  elevation: 4,
                                  onChanged: (String? value){
                                    _controller2.text = value!;
                                  }),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Days to repeat', style: TextStyle(fontSize: 10, color: Colors.green),),
                  _showWeekDays(),

                ],
              ),
            )),
            const SizedBox(height: 30,),
            _widgetCard(ListTile(
              title: const Text('Automatic mode', style: TextStyle(fontWeight: FontWeight.bold),),
              trailing: Switch(
                value: autoMode,
                onChanged: _autoMode,
                activeColor: Colors.white,
                activeTrackColor: Colors.green[700],
              ),
            )),
          ],
        ),
      ),
    );
  }

  _appBar(){
    return AppBar(
      elevation: 0,
      title: const Text(
        'Night Vision',
        style: TextStyle(
        fontWeight: FontWeight.bold,
          color: Colors.black
      ),
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leadingWidth: 40,
      leading: Row(
        children: [
          const SizedBox(width: 10,),
          Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black,),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _nightMode(bool value){

      if (nightMode == false) {
        setState(() {
          nightMode = true;
          debugPrint('Switch Button is ON');
        });

      }
      else {
        setState(() {
          nightMode = false;
        });
        debugPrint('Switch Button is OFF');
      }
  }

  void _scheduleNight(bool value){
      if (scheduleNight == false) {
        setState(() {
          scheduleNight = true;
        });
        debugPrint('Switch Button is ON');
      }
      else {
        setState(() {
          scheduleNight= false;
        });
        debugPrint('Switch Button is OFF');
      }

  }

  void _autoMode(bool value){
      if (autoMode == false) {
        setState(() {
          autoMode = true;
        });
        debugPrint('Switch Button is ON');
      }
      else {
        setState(() {
          autoMode = false;
        });
        debugPrint('Switch Button is OFF');
      }

  }

  _widgetCard(Widget? child){
    return Material(
      elevation: 5,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        child: Container(
        padding: const EdgeInsets.only(top: 10,bottom: 10),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(13),
    color: Colors.grey.withOpacity(0.09),
    ),
          child: child,
        ));
  }

_showTime(BuildContext context, bool isStart){
    return DatePicker.showTimePicker(context,
    currentTime: DateTime.now(),
      theme: const DatePickerTheme(
        containerHeight: 120,
      ),
      onConfirm: (time){
      setState(() {
        if(isStart == true){
          startTime = DateFormat('KK:mm').format(time).toString();
        }
        else{
          endTime = DateFormat('KK:mm').format(time).toString();
        }


      });
      },
    );
}

_showWeekDays(){
    return WeekdaySelectorTheme(
      data: WeekdaySelectorThemeData(
        fillColor: Colors.grey[350],
        selectedFillColor: Colors.white,
        selectedTextStyle: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.normal,
            // Beautiful!
            decoration: TextDecoration.none,
          inherit: false
        ),
        textStyle: TextStyle(
          color: Colors.grey[700],
            fontWeight: FontWeight.normal,
            // Beautiful!
            decoration: TextDecoration.none,
            inherit: false
        ),
        selectedShape: const CircleBorder(
            side: BorderSide(
                color: Colors.green
            )
        ),
      ),
      child: WeekdaySelector(
          onChanged: (int day){
            setState(() {
              final index = day % 7;
              values[index] = !values[index]!;
            });
          },
          values: values,
        firstDayOfWeek: 1,
        shortWeekdays: const ['Su', 'M', 'Tu', 'W', 'Th', 'F', 'Sa'],


      ),
    );
}

}
