import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/sidebar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import 'cycle_dashboard_model.dart';
export 'cycle_dashboard_model.dart';

class CycleDashboardWidget extends StatefulWidget {
  const CycleDashboardWidget({super.key});

  static String routeName = 'CycleDashboard';
  static String routePath = '/cycleDashboard';

  @override
  State<CycleDashboardWidget> createState() => _CycleDashboardWidgetState();
}

class _CycleDashboardWidgetState extends State<CycleDashboardWidget> {
  late CycleDashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CycleDashboardModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final _localAuth = LocalAuthentication();
      bool _isBiometricSupported = await _localAuth.isDeviceSupported();

      if (_isBiometricSupported) {
        try {
          _model.authResult = await _localAuth.authenticate(
              localizedReason: 'Scan your face to activate the lock.');
        } on PlatformException {
          _model.authResult = false;
        }
        safeSetState(() {});
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PeriodEntriesRecord>>(
      stream: queryPeriodEntriesRecord(
        parent: currentUserReference,
        queryBuilder: (periodEntriesRecord) =>
            periodEntriesRecord.orderBy('date'),
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<PeriodEntriesRecord> cycleDashboardPeriodEntriesRecordList =
            snapshot.data!;

        return Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          drawer: Drawer(
            elevation: 16,
            child: wrapWithModel(
              model: _model.sidebarModel,
              updateCallback: () => safeSetState(() {}),
              child: SidebarWidget(),
            ),
          ),
          body: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        FlutterFlowTheme.of(context).designToken.spacing.lg,
                        FlutterFlowTheme.of(context).designToken.spacing.lg,
                        FlutterFlowTheme.of(context).designToken.spacing.lg,
                        0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome, ',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .fontStyle,
                              ),
                        ),
                        AuthUserStreamWidget(
                          builder: (context) => Text(
                            currentUserDisplayName,
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineSmall
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineSmall
                                      .fontStyle,
                                ),
                          ),
                        ),
                        AuthUserStreamWidget(
                          builder: (context) => Container(
                            width: 48,
                            height: 48,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CachedNetworkImage(
                              fadeInDuration: Duration(milliseconds: 0),
                              fadeOutDuration: Duration(milliseconds: 0),
                              imageUrl: valueOrDefault<String>(
                                currentUserPhoto,
                                'https://static.vecteezy.com/system/resources/previews/024/983/914/non_2x/simple-user-default-icon-free-png.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if ((cycleDashboardPeriodEntriesRecordList.isNotEmpty) == true)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              FlutterFlowTheme.of(context)
                                  .designToken
                                  .spacing
                                  .lg,
                              0,
                              FlutterFlowTheme.of(context)
                                  .designToken
                                  .spacing
                                  .lg,
                              0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                dateTimeFormat(
                                    "MMMMEEEEd", getCurrentTimestamp),
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 400,
                        height: 60,
                        child: Builder(
                          builder: (context) {
                            final dayItem =
                                functions.getCurrentWeekDays().toList();

                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: dayItem.length,
                              itemBuilder: (context, dayItemIndex) {
                                final dayItemItem = dayItem[dayItemIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8, 0, 8, 0),
                                  child: Container(
                                    width: 44,
                                    height: 54,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          dateTimeFormat("EEEE", dayItemItem),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 10,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        Text(
                                          dateTimeFormat("d", dayItemItem),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                fontSize: 16,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                        if (functions.isPeriodDay(
                                            dayItemItem,
                                            cycleDashboardPeriodEntriesRecordList
                                                .map((e) => e.date)
                                                .withoutNulls
                                                .toList()))
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 4, 0, 3),
                                            child: Container(
                                              width: 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ].divide(SizedBox(
                        height: FlutterFlowTheme.of(context)
                            .designToken
                            .spacing
                            .md)),
                  ),
                if ((cycleDashboardPeriodEntriesRecordList.isNotEmpty) == true)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        FlutterFlowTheme.of(context).designToken.spacing.lg,
                        0,
                        FlutterFlowTheme.of(context).designToken.spacing.lg,
                        0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(FlutterFlowTheme.of(context)
                              .designToken
                              .spacing
                              .xl),
                          child: Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Current Phase',
                                            style: FlutterFlowTheme.of(context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                          Text(
                                            functions.calculateCurrentPhase(
                                                functions.calculateCurrentDay(
                                                    functions
                                                        .findPeriodStartDates(
                                                            cycleDashboardPeriodEntriesRecordList
                                                                .map((e) =>
                                                                    e.date)
                                                                .withoutNulls
                                                                .toList())
                                                        .lastOrNull!,
                                                    functions
                                                        .calculateAverageCycleLength(
                                                            cycleDashboardPeriodEntriesRecordList
                                                                .map((e) =>
                                                                    e.date)
                                                                .withoutNulls
                                                                .toList())),
                                                functions
                                                    .calculateAveragePeriodLength(
                                                        cycleDashboardPeriodEntriesRecordList
                                                            .map((e) => e.date)
                                                            .withoutNulls
                                                            .toList())),
                                            style: FlutterFlowTheme.of(context)
                                                .headlineMedium
                                                .override(
                                                  font: GoogleFonts.interTight(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .headlineMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ].divide(SizedBox(
                                            height: FlutterFlowTheme.of(context)
                                                .designToken
                                                .spacing
                                                .xs)),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              FlutterFlowTheme.of(context)
                                                  .designToken
                                                  .radius
                                                  .full),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              FlutterFlowTheme.of(context)
                                                  .designToken
                                                  .spacing
                                                  .md),
                                          child: Icon(
                                            Icons.water_drop_rounded,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Day ',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Text(
                                                  functions
                                                      .calculateCurrentDay(
                                                          functions
                                                              .findPeriodStartDates(
                                                                  cycleDashboardPeriodEntriesRecordList
                                                                      .map((e) => e
                                                                          .date)
                                                                      .withoutNulls
                                                                      .toList())
                                                              .lastOrNull!,
                                                          functions.calculateAverageCycleLength(
                                                              cycleDashboardPeriodEntriesRecordList
                                                                  .map((e) =>
                                                                      e.date)
                                                                  .withoutNulls
                                                                  .toList()))
                                                      .toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Text(
                                                  ' of ',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                                Text(
                                                  functions
                                                      .calculateAverageCycleLength(functions
                                                          .findPeriodStartDates(
                                                              cycleDashboardPeriodEntriesRecordList
                                                                  .map((e) =>
                                                                      e.date)
                                                                  .withoutNulls
                                                                  .toList())
                                                          .toList())
                                                      .toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      LinearPercentIndicator(
                                        percent: functions.calculateCycleProgress(
                                            functions.calculateCurrentDay(
                                                cycleDashboardPeriodEntriesRecordList
                                                    .lastOrNull!.date!,
                                                functions.calculateAverageCycleLength(
                                                    functions
                                                        .findPeriodStartDates(
                                                            cycleDashboardPeriodEntriesRecordList
                                                                .map((e) =>
                                                                    e.date)
                                                                .withoutNulls
                                                                .toList())
                                                        .toList())),
                                            functions.calculateAverageCycleLength(
                                                functions
                                                    .findPeriodStartDates(
                                                        cycleDashboardPeriodEntriesRecordList
                                                            .map((e) => e.date)
                                                            .withoutNulls
                                                            .toList())
                                                    .toList())),
                                        lineHeight: 8,
                                        animation: false,
                                        animateFromLastPercent: true,
                                        progressColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .alternate,
                                        barRadius: Radius.circular(4),
                                        padding: EdgeInsets.zero,
                                      ),
                                    ].divide(SizedBox(
                                        height: FlutterFlowTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md)),
                                  ),
                                  Divider(),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Likely Emotions',
                                        style: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                      ),
                                      Builder(
                                        builder: (context) {
                                          final emotionItem = functions
                                              .getEmotionsForPhase('')
                                              .toList();

                                          return Wrap(
                                            spacing:
                                                FlutterFlowTheme.of(context)
                                                    .designToken
                                                    .spacing
                                                    .sm,
                                            runSpacing:
                                                FlutterFlowTheme.of(context)
                                                    .designToken
                                                    .spacing
                                                    .sm,
                                            alignment: WrapAlignment.start,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.start,
                                            direction: Axis.horizontal,
                                            runAlignment: WrapAlignment.start,
                                            verticalDirection:
                                                VerticalDirection.down,
                                            clipBehavior: Clip.none,
                                            children: List.generate(
                                                emotionItem.length,
                                                (emotionItemIndex) {
                                              final emotionItemItem =
                                                  emotionItem[emotionItemIndex];
                                              return Container(
                                                  width: 100,
                                                  height: 100,
                                                  color: Colors.green);
                                            }),
                                          );
                                        },
                                      ),
                                    ].divide(SizedBox(
                                        height: FlutterFlowTheme.of(context)
                                            .designToken
                                            .spacing
                                            .sm)),
                                  ),
                                ].divide(SizedBox(
                                    height: FlutterFlowTheme.of(context)
                                        .designToken
                                        .spacing
                                        .lg)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(32, 0, 32, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed(DailyLogWidget.routeName);
                    },
                    text: 'Add Period Date',
                    options: FFButtonOptions(
                      height: 35,
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 0,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ].divide(SizedBox(
                  height: FlutterFlowTheme.of(context).designToken.spacing.lg)),
            ),
          ),
        );
      },
    );
  }
}