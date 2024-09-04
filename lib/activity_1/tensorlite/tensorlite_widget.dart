import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'tensorlite_model.dart';
export 'tensorlite_model.dart';

class TensorliteWidget extends StatefulWidget {
  const TensorliteWidget({super.key});

  @override
  State<TensorliteWidget> createState() => _TensorliteWidgetState();
}

class _TensorliteWidgetState extends State<TensorliteWidget> {
  late TensorliteModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TensorliteModel());
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
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.9,
                child: custom_widgets.MLDemo(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.9,
                  title: 'Laptop or Phone Detector',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
