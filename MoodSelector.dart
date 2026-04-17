import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'mood_selector_model.dart';
export 'mood_selector_model.dart';

class MoodSelectorWidget extends StatefulWidget {
  const MoodSelectorWidget({
    super.key,
    this.selected,
    this.emoji,
    this.label,
  });

  final bool? selected;
  final String? emoji;
  final String? label;

  @override
  State<MoodSelectorWidget> createState() => _MoodSelectorWidgetState();
}

class _MoodSelectorWidgetState extends State<MoodSelectorWidget> {
  late MoodSelectorModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MoodSelectorModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: widget!.selected == false
                ? FlutterFlowTheme.of(context).secondaryBackground
                : FlutterFlowTheme.of(context).accent1,
            borderRadius: BorderRadius.circular(
                FlutterFlowTheme.of(context).designToken.radius.full),
            border: Border.all(
              color: FlutterFlowTheme.of(context).accent1,
              width: 2,
            ),
          ),
          alignment: AlignmentDirectional(0, 0),
          child: Text(
            valueOrDefault<String>(
              widget!.emoji,
              '✨',
            ),
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        Text(
          valueOrDefault<String>(
            widget!.label,
            'Radiant',
          ),
          style: FlutterFlowTheme.of(context).labelSmall.override(
                font: GoogleFonts.inter(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelSmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
                ),
                color: widget!.selected == false
                    ? FlutterFlowTheme.of(context).secondaryText
                    : FlutterFlowTheme.of(context).primaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelSmall.fontStyle,
              ),
        ),
      ].divide(SizedBox(
          height: FlutterFlowTheme.of(context).designToken.spacing.xs)),
    );
  }
}