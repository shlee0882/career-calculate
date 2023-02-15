import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime initialDate = DateTime.now();
  String titleInfer = '';
  bool inInitial = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf6f4f7),
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _WorkDay(
              onCalendarPressed: onCalendarPressed,
              initialDate: initialDate,
              onInitialized: onInitialized,
              titleInfer: titleInfer,
            ),
            _WorkImage(),
          ],
        ),
      ),
    );
  }

  void onInitialized() {
    inInitial = true;
    if (inInitial) {
      setState(() {
        initialDate = DateTime.now();
        titleInfer = '';
      });
      inInitial = false;
    }
  }

  DateTime now = new DateTime.now();

  void onCalendarPressed() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              color: Colors.white,
              height: 300,
              child: CupertinoDatePicker(
                maximumDate: DateTime.now().add(Duration(hours: 1)),
                initialDateTime: initialDate,
                mode: CupertinoDatePickerMode.date,
                dateOrder: DatePickerDateOrder.ymd,
                use24hFormat: true,
                onDateTimeChanged: (DateTime date) {
                  var title = '';
                  if (date != null && date != initialDate) {
                    if (DateTime(now.year, now.month, now.day)
                        .difference(initialDate)
                        .inDays + 1 <= 1460) // 4
                      title = '사원-대리';
                    else if (DateTime(now.year, now.month, now.day)
                        .difference(initialDate)
                        .inDays + 1 <= 2920)
                      title = '대리-과장'; // 8
                    else if (DateTime(now.year, now.month, now.day)
                        .difference(initialDate)
                        .inDays + 1 <= 4745)
                      title = '과장-차장'; // 13
                    else if (DateTime(now.year, now.month, now.day)
                        .difference(initialDate)
                        .inDays + 1 <= 6570)
                      title = '차장-부장'; // 18
                    else if (DateTime(now.year, now.month, now.day)
                        .difference(initialDate)
                        .inDays + 1 <= 8030)
                      title = '부장-임원'; // 22
                    else title = 'CEO';
                    setState(() {
                      initialDate = date;
                      titleInfer = title;
                    });
                  }
                }
              )
          ),
        );
      },
      barrierDismissible: true,
    );
  }
}

class _WorkDay extends StatelessWidget {
  final GestureTapCallback onCalendarPressed;
  final DateTime initialDate;
  final GestureTapCallback onInitialized;
  final String titleInfer;

  const _WorkDay({
    required this.onCalendarPressed,
    required this.initialDate,
    required this.onInitialized,
    required this.titleInfer,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final now = DateTime.now();

    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 40.0,
          ),
          Text(
            '경력 계산기',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            '나는 얼마나 일했을까?',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onCalendarPressed,
                icon: Icon(
                  Icons.calendar_month,
                  color: Colors.lightBlue,
                  size: 38.0,
                ),
              ),
              IconButton(
                onPressed: onInitialized,
                icon: Icon(
                  Icons.refresh,
                  color: Colors.lightBlue,
                  size: 35.0,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            '근로시작일 ${initialDate.year}. ${initialDate.month < 10 ? '0'+(initialDate.month).toString() : initialDate.month}. ${initialDate.day}',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            '근로일수 :   ${DateTime(now.year, now.month, now.day).difference(initialDate).inDays + 1} 일',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
          ),
          Text(
            '근로연수 : ${((DateTime(now.year, now.month, now.day).difference(initialDate).inDays + 1) ~/ 365)}년 '
                '${((DateTime(now.year, now.month, now.day).difference(initialDate).inDays + 1) % 365) ~/ 30}개월',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            '${titleInfer != '' ? '직급은 '+titleInfer+' 일 것 같아요.' : ''}', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _WorkImage extends StatelessWidget {
  const _WorkImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Image.asset(
          'asset/img/idol.jpg',
          height: MediaQuery.of(context).size.height,
        ),
      ),
    );
  }
}
