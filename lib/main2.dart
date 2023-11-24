import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // MobileAds.instance.initialize();

  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, oriantation, screenType)
      {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Почивни дни',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      );
    });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    // _loadAd();
  }

  // BannerAd? _bannerAd;

  List vacationDays = [
    ///2023 DECEMBER
    {'date':DateTime.utc(2023, 12, 24), 'name': 'Бъдни вечер и Рождество Христово'},
    {'date':DateTime.utc(2023, 12, 25), 'name': 'Бъдни вечер и Рождество Христово'},
    {'date':DateTime.utc(2023, 12, 26), 'name': 'Бъдни вечер и Рождество Христово'},
    {'date':DateTime.utc(2023, 12, 27), 'name': 'Допълнителен почивен ден'},

    ///2024

    ///JAN
    {'date':DateTime.utc(2024, 1, 1), 'name': 'Нова Година'},

    ///MARCH
    {'date':DateTime.utc(2024, 3, 3), 'name': 'Ден на Освобождението на България от османско робство'},

    ///MAY
    {'date':DateTime.utc(2024, 5, 1), 'name': 'Ден на труда'},
    {'date':DateTime.utc(2024, 5, 3), 'name': 'Гергьовден, Ден'},
    {'date':DateTime.utc(2024, 5, 4), 'name': 'Гергьовден, Ден'},
    {'date':DateTime.utc(2024, 5, 5), 'name': 'Гергьовден, Ден'},
    {'date':DateTime.utc(2024, 5, 6), 'name': 'Гергьовден, Ден'},
    {'date':DateTime.utc(2024, 5, 24), 'name': 'Ден на българската просвета и култура '},

    ///SEPT
    {'date':DateTime.utc(2024, 9, 6), 'name': 'Ден на Съединението'},
    {'date':DateTime.utc(2024, 9, 22), 'name': 'Ден на Независимостта на България'},
    {'date':DateTime.utc(2024, 9, 23), 'name': 'Допълнителен почивен ден'},

    ///DEC
    {'date':DateTime.utc(2024, 12, 24), 'name': 'Бъдни вечер и Рождество Христово'},
    {'date':DateTime.utc(2024, 12, 25), 'name': 'Бъдни вечер и Рождество Христово'},
    {'date':DateTime.utc(2024, 12, 26), 'name': 'Бъдни вечер и Рождество Христово'},
  ];

  final List<DateTime> toHighlight = [
    DateTime.utc(2023, 12, 24),
    DateTime.utc(2023, 12, 25),
    DateTime.utc(2023, 12, 26),
    DateTime.utc(2023, 12, 27),
    DateTime.utc(2024, 1, 1),
    DateTime.utc(2024, 3, 3),
    DateTime.utc(2024, 5, 1),
    DateTime.utc(2024, 5, 3),
    DateTime.utc(2024, 5, 4),
    DateTime.utc(2024, 5, 5),
    DateTime.utc(2024, 5, 6),
    DateTime.utc(2024, 5, 24),
    DateTime.utc(2024, 9, 6),
    DateTime.utc(2024, 9, 22),
    DateTime.utc(2024, 9, 23),
    DateTime.utc(2024, 12, 24),
    DateTime.utc(2024, 12, 25),
    DateTime.utc(2024, 12, 26),

  ];

  DateTime focusedDate = DateTime.now();

  String selectedDateName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 3.h),
            TableCalendar(
              eventLoader: (day) {
                var events = [];
                for(var i = 0; i < vacationDays.length; i++)
                {
                  // print(day);
                  // print(vacationDays[i]['date']);
                  if(vacationDays[i]['date'] == day)
                    {
                      events.add(vacationDays[i]);
                    }
                }
                // print(events);
                return events;
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  focusedDate = selectedDay;
                });
                print(focusedDay);
                for(int i = 0; i < vacationDays.length; i++)
                {
                  if(vacationDays[i]['date'] == selectedDay)
                    {
                      setState(() {
                        selectedDateName = vacationDays[i]['name'];
                      });
                      break;
                    }
                }
              },
              locale: 'bg_BG',
              firstDay: DateTime.utc(2023, 11, 1),
              lastDay: DateTime.utc(2024, 12, 31),
              focusedDay: focusedDate,
              currentDay: DateTime.now(),
              selectedDayPredicate: (day) =>isSameDay(day, focusedDate),
              startingDayOfWeek: StartingDayOfWeek.monday,
              ///style
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 25.sp,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                  size: 45.sp,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 45.sp,
                ),
              ),
              calendarStyle: const CalendarStyle(
                // selectedDecoration: BoxDecoration(
                //   color: Colors.greenAccent,
                //   shape: BoxShape.rectangle,
                // ),
                weekendTextStyle:TextStyle(color: Colors.white),
                weekendDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.rectangle,
                ),
                markerDecoration: BoxDecoration(),
                ///???
                // outsideDaysVisible: false,
              ),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  for (DateTime d in toHighlight) {
                    if (day.day == d.day &&
                        day.month == d.month &&
                        day.year == d.year) {
                      return Padding(padding: EdgeInsets.all(6),child:Container(
                        decoration: const BoxDecoration(
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ));
                    }
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              height: 0.1.h,
              width: 100.w,
              color: Colors.grey,
            ),
            SizedBox(height: 2.h),
            Visibility(
              visible: toHighlight.contains(focusedDate),
              child: Center(
                child: Text('${DateFormat('dd/MM/yyyy').format(focusedDate)}: \n $selectedDateName', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ),
            ),

            // if (_bannerAd != null)
            //   Align(
            //     alignment: Alignment.bottomCenter,
            //     child: SafeArea(
            //       child: SizedBox(
            //         width: _bannerAd!.size.width.toDouble(),
            //         height: _bannerAd!.size.height.toDouble(),
            //         child: AdWidget(ad: _bannerAd!),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }




  // final String _adUnitId = 'ca-app-pub-1494100205446442/8549818138';
  //
  // void _loadAd() async {
  //   BannerAd(
  //     adUnitId: _adUnitId,
  //     request: const AdRequest(),
  //     size: AdSize.banner,
  //     listener: BannerAdListener(
  //       // Called when an ad is successfully received.
  //       onAdLoaded: (ad) {
  //         setState(() {
  //           _bannerAd = ad as BannerAd;
  //         });
  //       },
  //       // Called when an ad request failed.
  //       onAdFailedToLoad: (ad, err) {
  //         ad.dispose();
  //       },
  //       // Called when an ad opens an overlay that covers the screen.
  //       onAdOpened: (Ad ad) {},
  //       // Called when an ad removes an overlay that covers the screen.
  //       onAdClosed: (Ad ad) {},
  //       // Called when an impression occurs on the ad.
  //       onAdImpression: (Ad ad) {},
  //     ),
  //   ).load();
  // }

}
