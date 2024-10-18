import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shope_ease/network/bloc/profile/profile_bloc.dart';
import 'package:shope_ease/ui/profile/profile_button.dart';
import 'package:shope_ease/ui/profile/profile_tile.dart';
import 'package:shope_ease/utils/constants.dart';
import 'package:shope_ease/utils/util_widget.dart';
import 'package:shope_ease/widgets/shared_preference.dart';
import 'package:shope_ease/widgets/sized_box_heigh_width.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ProfileScreen extends StatefulWidget {
  final Function(int) navigateTo;

  const ProfileScreen({super.key, required this.navigateTo});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc profileBloc = ProfileBloc();

  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(ProfileInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        widget.navigateTo(0);
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF6F6F6),
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          toolbarHeight: 20,
          leading: const SizedBox(),
        ),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
           },
          builder: (context, state) {
            if (state is ProfileLoaded) {
              return SafeArea(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PreferredSize(
                      preferredSize:
                          Size.fromHeight(AppBar().preferredSize.height),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 32),
                        color: Colors.white,
                        child: const Row(
                          children: [
                            Text("Profile",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          state.image,
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        )),
                                    const CustomSizedBox(width: 18),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.name,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          state.email,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color(0xffFFF1D4)),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/coins.svg"),
                                          const CustomSizedBox(width: 4),
                                          const Text("250",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0xffFF8000)))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey.withOpacity(0.5),
                            thickness: 0.5,
                            height: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ProfileButtonWidget(
                                      title: "Previous orders",
                                      imageurl: "assets/icons/order.svg",
                                      onPress: () {
                                        Navigator.pushNamed(
                                            context, "/OrderHistoryScreen");
                                      },
                                    ),
                                    const CustomSizedBox(width: 12),
                                    ProfileButtonWidget(
                                      title: "Delivery Address",
                                      imageurl: "assets/icons/delivery.svg",
                                      onPress: () {
                                        Navigator.pushNamed(
                                            context, "/AddressScreen");
                                      },
                                    ),
                                  ],
                                ),
                                const CustomSizedBox(height: 12),
                                Row(
                                  children: [
                                    ProfileButtonWidget(
                                      title: "Wishlist",
                                      imageurl: "assets/icons/wishlist.svg",
                                      onPress: () {
                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
                                        widget.navigateTo(1);
                                      },
                                    ),
                                    const CustomSizedBox(width: 12),
                                    ProfileButtonWidget(
                                      title: "Help center",
                                      imageurl: "assets/icons/help_center.svg",
                                      onPress: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey.withOpacity(0.5),
                            thickness: 0.5,
                            height: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Account",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: textColor,
                                        fontWeight: FontWeight.w500)),
                                Theme(
                                  data: Theme.of(context).copyWith(
                                    dividerColor: Colors.transparent,

                                    listTileTheme: const ListTileThemeData(
                                        contentPadding: EdgeInsets.zero),
                                  ),
                                  child: ExpansionTile(
                                    leading: SvgPicture.asset(
                                        "assets/icons/user.svg"),
                                    title: const Text(
                                      'Personal details, password',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                    children: <Widget>[
                                      ProfileTile(
                                        strIcon: "assets/icons/edit_user.svg",
                                        title: "Edit Profile",
                                        onPress: () {
                                          Navigator.pushNamed(
                                              context, "/EditProfileScreen");
                                        },
                                      ),
                                      ProfileTile(
                                        strIcon: "assets/icons/key.svg",
                                        title: "Change Password",
                                        onPress: () {},
                                      ),
                                      ProfileTile(
                                        strIcon: "assets/icons/acc_delete.svg",
                                        title: "Deactivate Account",
                                        onPress: () {},
                                        textColor: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey.withOpacity(0.5),
                            thickness: 0.5,
                            height: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ProfileTile(
                              strIcon: "assets/icons/notification_bell.svg",
                              title: "Notifications",
                              onPress: () {
                                Navigator.pushNamed(
                                    context, "/NotificationScreen");
                              },
                              showPadding: false,
                            ),
                          ),
                          Divider(
                            color: Colors.grey.withOpacity(0.5),
                            thickness: 0.5,
                            height: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("General",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: textColor,
                                        fontWeight: FontWeight.w500)),
                                ProfileTile(
                                  strIcon: "assets/icons/info_symbol.svg",
                                  title: "About",
                                  onPress: () {},
                                ),
                                ProfileTile(
                                  strIcon: "assets/icons/padlock.svg",
                                  title: "Privacy Policy",
                                  onPress: () {},
                                ),
                                ProfileTile(
                                  strIcon: "assets/icons/logout.svg",
                                  title: state.isLoggedIn ? "Log out" : "Login",
                                  onPress: () {
                                    clearAllPreferences();
                                    Navigator.pushNamed(
                                        context, "/LoginScreen");
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
            } else {
              return Widgets().widgetLoader();
            }
          },
        ),
      ),
    );
  }

  Future<void> clearAllPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}
