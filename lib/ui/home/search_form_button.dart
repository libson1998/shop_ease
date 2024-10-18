import 'package:flutter/material.dart';
import 'package:shope_ease/network/model_class/product_response.dart';
import 'package:shope_ease/theme/theme.dart';
import 'package:shope_ease/utils/constants.dart';
import 'package:shope_ease/widgets/form_widget.dart';
import 'package:svg_flutter/svg_flutter.dart';

class SearchFormButton extends StatelessWidget {
  final List<Product> products;
  final Function(int) navigateTo;

  const SearchFormButton(
      {super.key, required this.products, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/SearchScreen",
              arguments: [products, navigateTo]);
        },
        child: FormFieldWidget(
          enabled: false,
          passwordObscure: false,
          isIconVisible: true,
          initialValue: "",
          onSave: (newValue) {
            // strSearchInput = newValue!;
          },
          onChange: (value) {
            // strSearchInput = value;
          },
          validator: (value) {
            if (value!.isEmpty) {
              return "This field cannot be empty";
            } else if (value.length > 9) {
              return "Please enter valid mobile number";
            }
            return null;
          },
          hintText: "Search on Dana plaza...",
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: blackColor, width: 1),
              borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: secondaryColor, width: 1),
              borderRadius: BorderRadius.circular(8)),
          errorBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          iconColor: kPrimaryColor,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset("assets/icons/search.svg"),
          ),
          keyboardType: TextInputType.emailAddress,
          hintStyle: TextStyle(
              fontSize: 14,
              color: const Color(0xff7A7979),
              fontWeight: FontWeight.w500),
          labelStyle: TextStyle(fontSize: 14, color: textColor),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset("assets/icons/Microphone.svg"),
          ),
        ));
  }
}
