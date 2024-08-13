import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import 'startup_model.dart';
export 'startup_model.dart';

class StartupWidget extends StatefulWidget {
  const StartupWidget({super.key});

  @override
  State<StartupWidget> createState() => _StartupWidgetState();
}

class _StartupWidgetState extends State<StartupWidget> {
  late StartupModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartupModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final _localAuth = LocalAuthentication();
      bool _isBiometricSupported = await _localAuth.isDeviceSupported();
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      if (_isBiometricSupported && canCheckBiometrics) {
        _model.loggedin = await _localAuth.authenticate(
            localizedReason: 'To access Addiction app',
            options: const AuthenticationOptions(biometricOnly: true));
        setState(() {});
      }

      if (_model.loggedin!) {
        context.goNamed('HomePage');
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
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 25),
                child: Text(
                  'Welcome back!',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Readex Pro',
                        fontSize: 34,
                        letterSpacing: 0,
                      ),
                ),
              ),
              PinCodeTextField(
                autoDisposeControllers: false,
                appContext: context,
                length: 6,
                textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0,
                    ),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                enableActiveFill: false,
                autoFocus: true,
                enablePinAutofill: false,
                errorTextSpace: 16,
                showCursor: true,
                cursorColor: FlutterFlowTheme.of(context).primary,
                obscureText: false,
                hintCharacter: '●',
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  fieldHeight: 44,
                  fieldWidth: 44,
                  borderWidth: 2,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  shape: PinCodeFieldShape.box,
                  activeColor: FlutterFlowTheme.of(context).primaryText,
                  inactiveColor: FlutterFlowTheme.of(context).alternate,
                  selectedColor: FlutterFlowTheme.of(context).primary,
                  activeFillColor: FlutterFlowTheme.of(context).primaryText,
                  inactiveFillColor: FlutterFlowTheme.of(context).alternate,
                  selectedFillColor: FlutterFlowTheme.of(context).primary,
                ),
                controller: _model.pinCodeController,
                onChanged: (_) {},
                onCompleted: (_) async {
                  if (_model.pinCodeController!.text == FFAppState().pincode) {
                    context.goNamed('HomePage');
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator:
                    _model.pinCodeControllerValidator.asValidator(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
