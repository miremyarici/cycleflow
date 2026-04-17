import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/intensity_item_widget.dart';
import '/components/mood_selector_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'daily_log_model.dart';
export 'daily_log_model.dart';

class DailyLogWidget extends StatefulWidget {
  const DailyLogWidget({super.key});

  static String routeName = 'DailyLog';
  static String routePath = '/dailyLog';

  @override
  State<DailyLogWidget> createState() => _DailyLogWidgetState();
}

class _DailyLogWidgetState extends State<DailyLogWidget> {
  late DailyLogModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DailyLogModel());

    _model.textController ??= TextEditingController(text: 'Start typing...');
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(
                  FlutterFlowTheme.of(context).designToken.spacing.lg,
                  FlutterFlowTheme.of(context).designToken.spacing.md,
                  FlutterFlowTheme.of(context).designToken.spacing.lg,
                  FlutterFlowTheme.of(context).designToken.spacing.md),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlutterFlowIconButton(
                    buttonSize: 40,
                    icon: Icon(
                      Icons.close_rounded,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24,
                    ),
                    onPressed: () async {
                      context.safePop();
                    },
                  ),
                  Text(
                    'Log Today',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .fontStyle,
                          ),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primary,
                      borderRadius: BorderRadius.circular(
                          FlutterFlowTheme.of(context).designToken.radius.sm),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Stack(
                        alignment: AlignmentDirectional(0, 0),
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await PeriodEntriesRecord.createDoc(
                                      currentUserReference!)
                                  .set({
                                ...createPeriodEntriesRecordData(
                                  date: _model.currentDate,
                                  intensity: _model.selectedIntensity,
                                  mood: _model.selectedMood,
                                  notes: _model.textController.text,
                                ),
                                ...mapToFirestore(
                                  {
                                    'symptoms': _model.selectedSymptoms,
                                  },
                                ),
                              });
                              context.safePop();
                            },
                            child: Container(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .spacing
                                        .md,
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .spacing
                                        .xs,
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .spacing
                                        .md,
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .spacing
                                        .xs),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 0,
                                      height: 0,
                                    ),
                                    Text(
                                      'Save',
                                      style: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Container(
                                      width: 0,
                                      height: 0,
                                    ),
                                  ].divide(SizedBox(width: 8)),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 0,
                            height: 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(
                  FlutterFlowTheme.of(context).designToken.spacing.lg),
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FlutterFlowIconButton(
                            buttonSize: 40,
                            icon: Icon(
                              Icons.chevron_left_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24,
                            ),
                            onPressed: () async {
                              _model.currentDate =
                                  date.subtract(Duration(days: 1));
                            },
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                dateTimeFormat(
                                    "MMMMEEEEd", getCurrentTimestamp),
                                style: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .fontStyle,
                                    ),
                              ),
                            ].divide(SizedBox(
                                height: FlutterFlowTheme.of(context)
                                    .designToken
                                    .spacing
                                    .xs)),
                          ),
                          FlutterFlowIconButton(
                            buttonSize: 40,
                            icon: Icon(
                              Icons.chevron_right_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 24,
                            ),
                            onPressed: () async {
                              _model.currentDate = date.add(Duration(days: 1));
                            },
                          ),
                        ].divide(SizedBox(
                            width: FlutterFlowTheme.of(context)
                                .designToken
                                .spacing
                                .md)),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Flow Intensity',
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                              ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.selectedIntensity = 'None';
                                  safeSetState(() {});
                                },
                                child: wrapWithModel(
                                  model: _model.intensityItemModel1,
                                  updateCallback: () => safeSetState(() {}),
                                  child: IntensityItemWidget(
                                    selected: true,
                                    label: 'None',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.selectedIntensity = 'Light';
                                  safeSetState(() {});
                                },
                                child: wrapWithModel(
                                  model: _model.intensityItemModel2,
                                  updateCallback: () => safeSetState(() {}),
                                  child: IntensityItemWidget(
                                    selected: false,
                                    label: 'Light',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.selectedIntensity = 'Medium';
                                  safeSetState(() {});
                                },
                                child: wrapWithModel(
                                  model: _model.intensityItemModel3,
                                  updateCallback: () => safeSetState(() {}),
                                  child: IntensityItemWidget(
                                    selected: false,
                                    label: 'Medium',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.selectedIntensity = 'Heavy';
                                  safeSetState(() {});
                                },
                                child: wrapWithModel(
                                  model: _model.intensityItemModel4,
                                  updateCallback: () => safeSetState(() {}),
                                  child: IntensityItemWidget(
                                    selected: false,
                                    label: 'Heavy',
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(
                              width: FlutterFlowTheme.of(context)
                                  .designToken
                                  .spacing
                                  .md)),
                        ),
                      ].divide(SizedBox(
                          height: FlutterFlowTheme.of(context)
                              .designToken
                              .spacing
                              .md)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How are you feeling?',
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                              ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.selectedMood = 'Radiant';
                                safeSetState(() {});
                              },
                              child: wrapWithModel(
                                model: _model.moodSelectorModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: MoodSelectorWidget(
                                  selected: true,
                                  emoji: '✨',
                                  label: 'Radiant',
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.selectedMood = 'Happy';
                                safeSetState(() {});
                              },
                              child: wrapWithModel(
                                model: _model.moodSelectorModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: MoodSelectorWidget(
                                  selected: false,
                                  emoji: '😊',
                                  label: 'Happy',
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.selectedMood = 'Tired';
                                safeSetState(() {});
                              },
                              child: wrapWithModel(
                                model: _model.moodSelectorModel3,
                                updateCallback: () => safeSetState(() {}),
                                child: MoodSelectorWidget(
                                  selected: false,
                                  emoji: '😴',
                                  label: 'Tired',
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.selectedMood = 'Low';
                                safeSetState(() {});
                              },
                              child: wrapWithModel(
                                model: _model.moodSelectorModel4,
                                updateCallback: () => safeSetState(() {}),
                                child: MoodSelectorWidget(
                                  selected: false,
                                  emoji: '😔',
                                  label: 'Low',
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.selectedMood = 'Angry';
                                safeSetState(() {});
                              },
                              child: wrapWithModel(
                                model: _model.moodSelectorModel5,
                                updateCallback: () => safeSetState(() {}),
                                child: MoodSelectorWidget(
                                  selected: false,
                                  emoji: '😠',
                                  label: 'Angry',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ].divide(SizedBox(
                          height: FlutterFlowTheme.of(context)
                              .designToken
                              .spacing
                              .md)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Common Symptoms',
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                              ),
                        ),
                        Wrap(
                          spacing: FlutterFlowTheme.of(context)
                              .designToken
                              .spacing
                              .sm,
                          runSpacing: FlutterFlowTheme.of(context)
                              .designToken
                              .spacing
                              .sm,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.start,
                          direction: Axis.horizontal,
                          runAlignment: WrapAlignment.start,
                          verticalDirection: VerticalDirection.down,
                          clipBehavior: Clip.none,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  0,
                                  FlutterFlowTheme.of(context)
                                      .designToken
                                      .spacing
                                      .sm,
                                  FlutterFlowTheme.of(context)
                                      .designToken
                                      .spacing
                                      .sm),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (_model.selectedSymptoms
                                      .contains('Cramps')) {
                                    _model.removeFromSelectedSymptoms('Cramps');
                                    safeSetState(() {});
                                  } else {
                                    _model.addToSelectedSymptoms('Cramps');
                                    safeSetState(() {});
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .radius
                                            .lg),
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).divider,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.water_drop_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 18,
                                        ),
                                        Text(
                                          'Cramps',
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                      ].divide(SizedBox(
                                          width: FlutterFlowTheme.of(context)
                                              .designToken
                                              .spacing
                                              .xs)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  0,
                                  FlutterFlowTheme.of(context)
                                      .designToken
                                      .spacing
                                      .sm,
                                  FlutterFlowTheme.of(context)
                                      .designToken
                                      .spacing
                                      .sm),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (_model.selectedSymptoms
                                      .contains('Energy Burst')) {
                                    _model.removeFromSelectedSymptoms(
                                        'Energy Burst');
                                    safeSetState(() {});
                                  } else {
                                    _model
                                        .addToSelectedSymptoms('Energy Burst');
                                    safeSetState(() {});
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .radius
                                            .lg),
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.bolt_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          size: 18,
                                        ),
                                        Text(
                                          'Energy Burst',
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                      ].divide(SizedBox(
                                          width: FlutterFlowTheme.of(context)
                                              .designToken
                                              .spacing
                                              .xs)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  0,
                                  FlutterFlowTheme.of(context)
                                      .designToken
                                      .spacing
                                      .sm,
                                  FlutterFlowTheme.of(context)
                                      .designToken
                                      .spacing
                                      .sm),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (_model.selectedSymptoms
                                      .contains('Acne')) {
                                    _model.removeFromSelectedSymptoms('Acne');
                                    safeSetState(() {});
                                  } else {
                                    _model.addToSelectedSymptoms('Acne');
                                    safeSetState(() {});
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .radius
                                            .lg),
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).divider,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.face_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 18,
                                        ),
                                        Text(
                                          'Acne',
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                      ].divide(SizedBox(
                                          width: FlutterFlowTheme.of(context)
                                              .designToken
                                              .spacing
                                              .xs)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  0,
                                  FlutterFlowTheme.of(context)
                                      .designToken
                                      .spacing
                                      .sm,
                                  FlutterFlowTheme.of(context)
                                      .designToken
                                      .spacing
                                      .sm),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (_model.selectedSymptoms
                                      .contains('Cravings')) {
                                    _model
                                        .removeFromSelectedSymptoms('Cravings');
                                    safeSetState(() {});
                                  } else {
                                    _model.addToSelectedSymptoms('Cravings');
                                    safeSetState(() {});
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context).primary,
                                    borderRadius: BorderRadius.circular(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .radius
                                            .lg),
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.restaurant_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          size: 18,
                                        ),
                                        Text(
                                          'Cravings',
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                      ].divide(SizedBox(
                                          width: FlutterFlowTheme.of(context)
                                              .designToken
                                              .spacing
                                              .xs)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  0,
                                  FlutterFlowTheme.of(context)
                                      .designToken
                                      .spacing
                                      .sm,
                                  FlutterFlowTheme.of(context)
                                      .designToken
                                      .spacing
                                      .sm),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (_model.selectedSymptoms
                                      .contains('Bloating')) {
                                    _model
                                        .removeFromSelectedSymptoms('Bloating');
                                    safeSetState(() {});
                                  } else {
                                    _model.addToSelectedSymptoms('Bloating');
                                    safeSetState(() {});
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .radius
                                            .lg),
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).divider,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.self_improvement_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 18,
                                        ),
                                        Text(
                                          'Bloating',
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                      ].divide(SizedBox(
                                          width: FlutterFlowTheme.of(context)
                                              .designToken
                                              .spacing
                                              .xs)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0,
                                  0,
                                  FlutterFlowTheme.of(context)
                                      .designToken
                                      .spacing
                                      .sm,
                                  FlutterFlowTheme.of(context)
                                      .designToken
                                      .spacing
                                      .sm),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (_model.selectedSymptoms
                                      .contains('Breast Tenderness')) {
                                    _model.removeFromSelectedSymptoms(
                                        'Breast Tenderness');
                                    safeSetState(() {});
                                  } else {
                                    _model.addToSelectedSymptoms(
                                        'Breast Tenderness');
                                    safeSetState(() {});
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .radius
                                            .lg),
                                    border: Border.all(
                                      color:
                                          FlutterFlowTheme.of(context).divider,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .spacing
                                            .md),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.favorite_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 18,
                                        ),
                                        Text(
                                          'Breast Tenderness',
                                          style: FlutterFlowTheme.of(context)
                                              .labelLarge
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelLarge
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelLarge
                                                        .fontStyle,
                                              ),
                                        ),
                                      ].divide(SizedBox(
                                          width: FlutterFlowTheme.of(context)
                                              .designToken
                                              .spacing
                                              .xs)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ].divide(SizedBox(
                          height: FlutterFlowTheme.of(context)
                              .designToken
                              .spacing
                              .md)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notes',
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                font: GoogleFonts.interTight(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                              ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                width: 0,
                                height: 0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                      FlutterFlowTheme.of(context)
                                          .designToken
                                          .radius
                                          .sm),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context).outline,
                                    width: 1,
                                  ),
                                ),
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .spacing
                                            .sm,
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .spacing
                                            .sm,
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .spacing
                                            .sm,
                                        FlutterFlowTheme.of(context)
                                            .designToken
                                            .spacing
                                            .sm),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.edit_note_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 16,
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: TextFormField(
                                            controller: _model.textController,
                                            focusNode:
                                                _model.textFieldFocusNode,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              hintText:
                                                  'Add details about your day...',
                                              hintStyle: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .hint,
                                              ),
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              focusedErrorBorder:
                                                  InputBorder.none,
                                            ),
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
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
                                            validator: _model
                                                .textControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                        Container(
                                          width: 0,
                                          height: 0,
                                        ),
                                      ].divide(SizedBox(
                                          width: FlutterFlowTheme.of(context)
                                              .designToken
                                              .spacing
                                              .sm)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 0,
                                height: 0,
                              ),
                            ].divide(SizedBox(height: 6)),
                          ),
                        ),
                      ].divide(SizedBox(
                          height: FlutterFlowTheme.of(context)
                              .designToken
                              .spacing
                              .md)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(
                            FlutterFlowTheme.of(context).designToken.radius.lg),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).divider,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(FlutterFlowTheme.of(context)
                            .designToken
                            .spacing
                            .lg),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    FlutterFlowTheme.of(context)
                                        .designToken
                                        .radius
                                        .md),
                              ),
                              alignment: AlignmentDirectional(0, 0),
                              child: Icon(
                                Icons.apple,
                                color: Color(0xFFFF2D55),
                                size: 24,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Syncing with Apple Health',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                  Text(
                                    'Basal body temperature and sleep data updated 2m ago',
                                    maxLines: 2,
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodySmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .fontStyle,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ].divide(SizedBox(
                                    height: FlutterFlowTheme.of(context)
                                        .designToken
                                        .spacing
                                        .xs)),
                              ),
                            ),
                            Icon(
                              Icons.sync_rounded,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20,
                            ),
                          ].divide(SizedBox(
                              width: FlutterFlowTheme.of(context)
                                  .designToken
                                  .spacing
                                  .md)),
                        ),
                      ),
                    ),
                    Container(
                      height:
                          FlutterFlowTheme.of(context).designToken.spacing.xl,
                    ),
                  ].divide(SizedBox(
                      height:
                          FlutterFlowTheme.of(context).designToken.spacing.xl)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}