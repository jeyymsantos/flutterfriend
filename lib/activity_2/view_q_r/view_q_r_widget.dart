import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'view_q_r_model.dart';
export 'view_q_r_model.dart';

class ViewQRWidget extends StatefulWidget {
  const ViewQRWidget({
    super.key,
    required this.qrText,
    required this.qrDateTime,
    required this.qrType,
  });

  final String? qrText;
  final DateTime? qrDateTime;
  final String? qrType;

  @override
  State<ViewQRWidget> createState() => _ViewQRWidgetState();
}

class _ViewQRWidgetState extends State<ViewQRWidget> {
  late ViewQRModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ViewQRModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'View QR',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: valueOrDefault<String>(
                            widget.qrType,
                            'Type',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: widget.qrType == 'Scanned'
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context).error,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const TextSpan(
                          text: ' | ',
                          style: TextStyle(),
                        ),
                        TextSpan(
                          text: dateTimeFormat("relative", widget.qrDateTime),
                          style: const TextStyle(),
                        )
                      ],
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            letterSpacing: 0.0,
                          ),
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: BarcodeWidget(
                    data: widget.qrText!,
                    barcode: Barcode.qrCode(),
                    width: 200.0,
                    height: 200.0,
                    color: FlutterFlowTheme.of(context).primaryText,
                    backgroundColor: Colors.transparent,
                    errorBuilder: (context, error) => const SizedBox(
                      width: 200.0,
                      height: 200.0,
                    ),
                    drawText: false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      widget.qrText,
                      'QR Code Result',
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          letterSpacing: 0.0,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
