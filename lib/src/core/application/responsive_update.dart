// import 'package:arifayduran_dev/src/core/my_toolbar.dart';
import 'package:arifayduran_dev/src/features/settings/data/session_settings.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

// void initializeToolbarHeight(BuildContext context) {
//   final toolbarProvider = Provider.of<ToolbarProvider>(context, listen: false);
//   responsiveUpdate(context);
//   toolbarProvider.toolbarHeight = maxBarsHeight;
// }
// if (!isToolbarInitialized) {
//           initializeToolbarHeight(context);
//           isToolbarInitialized = true;
//         }

// isToolbarInitialized sil

void responsiveUpdate(BuildContext context) {
  // final double height = MediaQuery.of(context).size.height;

  // final toolbarProvider = Provider.of<ToolbarProvider>(context, listen: false); // didtn used for now

  // final bottombarProvider =
  //     Provider.of<BottombarProvider>(context, listen: false);

  if (ResponsiveBreakpoints.of(context).smallerThan("Big")) {
    // toolbarProvider.providersmaxBarsHeight = 60;
    // toolbarProvider.providersminBarsHeight = 40;

    // bottombarProvider.providersMaxBottombarHeight = 60; // didtn used for now
    // bottombarProvider.providersMinBottombarHeight = 40; // didtn used for now
    maxBarsHeight = 60;
    minBarsHeight = 40;
  } else {
    // bottombarProvider.providersMaxBottombarHeight = 80;
    // bottombarProvider.providersMinBottombarHeight = 60;
    maxBarsHeight = 80;
    minBarsHeight = 60;
  }
}
