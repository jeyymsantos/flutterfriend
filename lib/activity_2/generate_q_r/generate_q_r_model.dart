import '/flutter_flow/flutter_flow_util.dart';
import 'generate_q_r_widget.dart' show GenerateQRWidget;
import 'package:flutter/material.dart';

class GenerateQRModel extends FlutterFlowModel<GenerateQRWidget> {
  ///  Local state fields for this page.

  String? qrCode;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? _textControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    textControllerValidator = _textControllerValidator;
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
