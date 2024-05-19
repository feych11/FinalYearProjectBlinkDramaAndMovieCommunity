import 'package:finalsemproject/AcceptedToRewriteScreen2.dart';
import 'package:finalsemproject/Screens/AcceptedToRewriteScreen1.dart';
import 'package:finalsemproject/Screens/AcceptedToRewriteScreen3.dart';
import 'package:finalsemproject/Screens/CustomeSendPerposal.dart';
import 'package:finalsemproject/Screens/DetailsScreen.dart';
import 'package:finalsemproject/Screens/EditorAddCommentsFroWriterScreen.dart';
import 'package:finalsemproject/Screens/EditorDashboardScreen.dart';

import 'package:finalsemproject/Screens/EditorNotificationScreen.dart';
import 'package:finalsemproject/Screens/EditorReadingScreen.dart';
import 'package:finalsemproject/Screens/FavouriteScreen.dart';
import 'package:finalsemproject/Screens/HistoryScreen.dart';
import 'package:finalsemproject/Screens/MoviesandDarama.dart';
import 'package:finalsemproject/Screens/ReaderBottomNavScreen.dart';
import 'package:finalsemproject/Screens/ReaderHomePageScreen.dart';
import 'package:finalsemproject/Screens/ReaderLoginScreen.dart';
import 'package:finalsemproject/Screens/ReaderSelectInterestsScreen.dart';
import 'package:finalsemproject/Screens/ReaderSignUpScreen.dart';
import 'package:finalsemproject/Screens/ReaderSubcriptionScreen.dart';
import 'package:finalsemproject/Screens/ReadingScreen.dart';
import 'package:finalsemproject/Screens/SendPerposal.dart';
import 'package:finalsemproject/Screens/SplashScreen.dart';
import 'package:finalsemproject/Screens/WatchingScreen.dart';
import 'package:finalsemproject/Screens/WriterAcceptedProjectsScreen.dart';
import 'package:finalsemproject/Screens/BalanceRequestScreen.dart';
import 'package:finalsemproject/Screens/WriterAccountSettingScreen.dart';
import 'package:finalsemproject/Screens/WriterLoginScreen.dart';
import 'package:finalsemproject/Screens/WriterMakingClipsScreen.dart';

import 'package:finalsemproject/Screens/WriterNotificationScreen.dart';
import 'package:finalsemproject/Screens/WriterSendSummaryScreen.dart';
import 'package:finalsemproject/Screens/WriterWriteSummaryScreen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: Colors.black,
        primarySwatch:Colors.green,

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Splashscreen(),
    );
  }
}