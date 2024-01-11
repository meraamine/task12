import 'dart:js';

import 'package:flutter/material.dart';
import 'package:shopify_app/pages/notification_page.dart';
import 'package:shopify_app/utils/colors.util.dart';
import 'package:shopify_app/widgets/icon_badge.widget.dart';

class AppBarEx {
  static PreferredSizeWidget get getAppBar => AppBar(
        surfaceTintColor: Colors.white,
        actions: [
          const CartBadgeWidget(),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context as BuildContext,
                      MaterialPageRoute(builder: (_) => NotificationsPage()));
                },
                icon: Icon(
                  Icons.notifications_outlined,
                  color: ColorsUtil.iconColor,
                ),
              ),
              Positioned(
                  bottom: 6,
                  child: Badge(
                    backgroundColor: ColorsUtil.badgeColor,
                    label: Text('5'),
                  ))
            ],
          ),
        ],
      );
}
