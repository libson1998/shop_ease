import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shope_ease/network/model_class/product_response.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/utils/constants.dart';
import 'package:shope_ease/widgets/form_widget.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:svg_flutter/svg_flutter.dart';

class DetailsAppbar extends StatefulWidget {
  final List<Product>? product;
  final bool isFormEnabled;

  const DetailsAppbar(
      {super.key,   this.product, this.isFormEnabled = false});

  @override
  State<DetailsAppbar> createState() => _DetailsAppbarState();
}

class _DetailsAppbarState extends State<DetailsAppbar> {
  final SpeechToText _speechToText = SpeechToText();
  TextEditingController textEditingController = TextEditingController();
  bool speechEnabled = false;
  String strSearchInput = "";

  @override
  void initState() {
    super.initState();
    getPermission();
    _initSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset("assets/icons/arrow_Left.svg")),
            const CustomSizedBox(width: 18),
            Expanded(
              child: InkWell(
                onTap: () {

                },
                child: FormFieldWidget(
                  enabled: widget.isFormEnabled,
                  passwordObscure: false,
                  isIconVisible: true,
                  onSave: (newValue) {
                    strSearchInput = newValue!;
                  },
                  onChange: (value) {
                    strSearchInput = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field cannot be empty";
                    } else if (value.length > 9) {
                      return "Please enter a valid mobile number";
                    }
                    return null;
                  },
                  hintText: "Search on Dana plaza...",
                  controller: textEditingController,

                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: blackColor, width: 1),
                      borderRadius: BorderRadius.circular(8)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: secondaryColor, width: 1),
                      borderRadius: BorderRadius.circular(8)),
                  errorBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  iconColor: kPrimaryColor,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: SvgPicture.asset("assets/icons/search.svg"),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  hintStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff7A7979),
                      fontWeight: FontWeight.w500),
                  labelStyle: const TextStyle(fontSize: 14, color: textColor),
                  child: InkWell(
                    onTap: () {
                      HapticFeedback.heavyImpact();
                      _speechToText.isNotListening
                          ? _startListening()
                          : _stopListening();
                    },
                    child: Padding(
                      padding: EdgeInsets.all(
                          _speechToText.isNotListening ? 12.0 : 4.0),
                      child: _speechToText.isNotListening
                          ? SvgPicture.asset("assets/icons/Microphone.svg",
                              color: const Color(0xff7A7979))
                          : Image.asset("assets/lottie/record.gif",
                              height: 24, color: Colors.green),
                    ),
                  ),
                ),
              ),
            ),
            const CustomSizedBox(width: 18),
            SvgPicture.asset("assets/icons/bag.svg",
                color: Colors.black, height: 30, width: 30),
          ],
        ),
      ),
    );
  }

  getPermission() async {
    await Permission.microphone.request();
    if ((await Permission.microphone.status == PermissionStatus.granted)) {
    } else {}
  }

  void _initSpeech() async {
    speechEnabled = await _speechToText.initialize();
    if (speechEnabled) {
      print("Speech recognition initialized successfully");
    } else {
      print("Speech recognition failed to initialize");
    }
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {

    final recognizedMessage = result.recognizedWords;

    setState(() {
      textEditingController.text = recognizedMessage;
      strSearchInput = recognizedMessage;
    });
  }
}
