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
                      title = '??????-??????';
                    else if (DateTime(now.year, now.month, now.day)
                        .difference(initialDate)
                        .inDays + 1 <= 2920)
                      title = '??????-??????'; // 8
                    else if (DateTime(now.year, now.month, now.day)
                        .difference(initialDate)
                        .inDays + 1 <= 4745)
                      title = '??????-??????'; // 13
                    else if (DateTime(now.year, now.month, now.day)
                        .difference(initialDate)
                        .inDays + 1 <= 6570)
                      title = '??????-??????'; // 18
                    else if (DateTime(now.year, now.month, now.day)
                        .difference(initialDate)
                        .inDays + 1 <= 8030)
                      title = '??????-??????'; // 22
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
            '?????? ?????????',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            '?????? ????????? ?????????????',
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
            '??????????????? ${initialDate.year}. ${initialDate.month < 10 ? '0'+(initialDate.month).toString() : initialDate.month}. ${initialDate.day}',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            '???????????? :   ${DateTime(now.year, now.month, now.day).difference(initialDate).inDays + 1} ???',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
          ),
          Text(
            '???????????? : ${((DateTime(now.year, now.month, now.day).difference(initialDate).inDays + 1) ~/ 365)}??? '
                '${((DateTime(now.year, now.month, now.day).difference(initialDate).inDays + 1) % 365) ~/ 30}??????',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            '${titleInfer != '' ? '????????? '+titleInfer+' ??? ??? ?????????.' : ''}', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
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
