import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  final int codeLength;
  final bool autoConfirm;
  final bool numeric;
  final bool obscureText;
  final Function callBack;
  final String errorText;
  final String title;
  bool hasError;
  bool hasSuccess;

  static bool fromNext = false;
  final String spacer = ' ';

  Otp({
    this.codeLength = 4,
    this.autoConfirm = true,
    this.numeric = true,
    this.obscureText = false,
    this.callBack,
    this.hasError = false,
    this.hasSuccess = false,
    this.errorText = '',
    this.title = '',
  });

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final controllers = List<TextEditingController>();

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    controllers.forEach((element) {
      element.dispose();
    });
    super.dispose();
  }

  void initData() {
    for (var i = 0; i < widget.codeLength; i++) {
      var controller = TextEditingController()..text = widget.spacer;
      controllers.add(controller);
    }
  }

  void setError(val) {
    setState(() {
      widget.hasError = val;
    });
  }

  void setSuccess(val) {
    setState(() {
      widget.hasSuccess = val;
    });
  }

  generateInputs() {
    var inputs = List<Widget>();
    for (var i = 0; i < widget.codeLength; i++) {
      inputs.add(generateInput(index: i));
    }
    return inputs;
  }

  String getCode() {
    String code = '';
    controllers.forEach((TextEditingController controller) {
      code += controller.text.replaceAll(widget.spacer, '');
    });
    return code;
  }

  Widget generateInput({index: 0}) {
    return Container(
      width: 60,
      margin: EdgeInsets.all(10),
      child: TextFormField(
        controller: controllers[index],
        autofocus: index == 0,
        style: TextStyle(
            color: this.widget.hasSuccess ? Colors.green : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 28),
        textAlign: TextAlign.center,
        maxLength: (index == 0 ? 1 : 2),
        obscureText: this.widget.obscureText,
        enableSuggestions: false,
        keyboardType:
            this.widget.numeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          contentPadding:
              EdgeInsets.only(left: (index == 0 ? 20 : 14), top: 16, right: 16, bottom: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.green)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              borderSide: BorderSide(color: Colors.blue)),
          errorText: this.widget.hasError ? '' : null,
          counterText: '',
        ),
        onChanged: (text) {
          var code = getCode();

          if (text.isEmpty) {
            if (index > 0) {
              Future.delayed(Duration(microseconds: 1), () {
                controllers[index].text = widget.spacer;
              });

              if (index == 1)
                controllers[index - 1].text = "";
              else
                controllers[index - 1].text = widget.spacer;
              FocusScope.of(context).previousFocus();
            }
          } else {
            if (code.length == controllers.length && text.length == 2) {
              FocusScope.of(context).unfocus();
              widget.callBack(code);
            } else if (index == 0 || text.length == 2) {
              FocusScope.of(context).nextFocus();
            }

            // reset states
            if (code.length != controllers.length) {
              this.setError(false);
              this.setSuccess(false);
            }
          }
        },
        onTap: () => {
          controllers[index].selection = TextSelection.collapsed(offset: controllers[index].text.length),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Text(widget.title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.black)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: generateInputs(),
        ),
        Text((widget.hasError ? widget.errorText : ''),
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w300, color: Colors.red)),
      ],
    );
  }
}
