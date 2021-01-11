import 'package:flutter/material.dart';

import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/FL/Screen/downloadscreenFL.dart';
import 'package:mimos/FL/Screen/trialscreenFL.dart';
import 'package:mimos/FL/Screen/uploadscreenFL.dart';
import 'package:mimos/PR/screen/report/report_screen.dart';
import 'package:mimos/PR/screen/transaction/display/display_screen.dart';
import 'package:mimos/PR/screen/transaction/penjualan/penjualan_screen.dart';
import 'package:mimos/PR/screen/transaction/posm/posm_screen.dart';
import 'package:mimos/PR/screen/transaction/stok/form/stock_form_screen.dart';
import 'package:mimos/PR/screen/transaction/stok/stock_screen.dart';
import 'package:mimos/PR/screen/trial/form/trial_form_pr_screen.dart';
import 'package:mimos/PR/screen/trial/trial_screen.dart';
import 'package:mimos/Screen/splashscreen.dart';
import 'package:mimos/Screen/loginscreen.dart';
import 'package:mimos/TF/Screen/downloadscreentf.dart';
import 'package:mimos/TF/Screen/listviewcustomertf.dart';
import 'package:mimos/TF/Screen/listviewintrodealtf.dart';
import 'package:mimos/TF/Screen/listviewmaterialtf.dart';
import 'package:mimos/TF/Screen/listviewpricetf.dart';
import 'package:mimos/TF/Screen/prosesdownloadscreentf.dart';
import 'package:mimos/TF/Screen/visitingscreentf.dart';
import 'package:mimos/TF/Screen/listcustomervisitscreentf.dart';
import 'package:mimos/TF/Screen/ringkasanscreentf.dart';
import 'package:mimos/TF/Screen/uploadscreentf.dart';
import 'package:mimos/TF/Screen/checksellinupload.dart';
import 'package:mimos/TF/Screen/checkposmupload.dart';
import 'package:mimos/TF/Screen/checkstockupload.dart';
import 'package:mimos/TF/Screen/checkvisibilityupload.dart';
import 'package:mimos/FL/Screen/trialformscreenFL.dart';
import 'package:mimos/PR/screen/download/download_screen.dart';
import 'package:mimos/PR/screen/upload/upload_screen.dart';
import 'package:mimos/PR/screen/visit/visit_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> generate() => {
        LOGIN_SCREEN: (BuildContext context) => new LogInScreen(),
        //SIGN_UP_SCREEN: (BuildContext context) => new SignUpScreen(),
        //-------- TF
        DOWNLOAD_SCREEN_TF: (BuildContext context) => new DownloadScreenTF(),
        PROSES_DOWNLOAD_DATA_TF: (BuildContext context) =>
            new ProsesDownloadDataTF(),
        LIST_VIEW_CUSTOMER_TF: (BuildContext context) =>
            new ListViewCustomerTF(),
        LIST_VIEW_MATERIAL_TF: (BuildContext context) =>
            new ListViewMaterialTF(),
        LIST_VIEW_PRICE_TF: (BuildContext context) => new ListViewPriceTF(),
        LIST_VIEW_INTRODEAL_TF: (BuildContext context) =>
            new ListViewIntrodealTF(),
        VISIT_SCREEN_TF: (BuildContext context) => new VisitScreenTF(),
        VISITING_SCREEN_TF: (BuildContext context) => new VisitingScreenTF(),
        RINGKASAN_SCREEN_TF: (BuildContext context) => new RingkasanScreenTF(),
        UPLOAD_SCREEN: (BuildContext context) => new UploadScreenTF(),
        CHECK_SELLIN_UPLOAD_SCREEN: (BuildContext context) =>
            new CheckSellinUpload(),
        CHECK_POSM_UPLOAD_SCREEN: (BuildContext context) =>
            new CheckPosmUpload(),
        CHECK_STOCK_UPLOAD_SCREEN: (BuildContext context) =>
            new CheckStockUpload(),
        CHECK_VISIBILITY_UPLOAD_SCREEN: (BuildContext context) =>
            new CheckVisibilityUpload(),
        //------ END TF
        //-------- FL
        DOWNLOAD_SCREEN_FL: (BuildContext context) => new DownloadScreenFL(),
        TRIAL_SCREEN_FL: (BuildContext context) => new TrialScreenFL(),
        TRIAL_FORM_SCREEN_FL: (BuildContext context) => new TrialFormScreenFL(),

        UPLOAD_SCREEN_FL: (BuildContext context) => new UploadScreenFL(),
        //------ END FL
        ANIMATED_SPLASH: (BuildContext context) => new SplashScreen(),
        //-------- PR
        // HOME
        DOWNLOAD_SCREEN_PR: (BuildContext context) => new DownloadScreen(),
        VISIT_SCREEN_PR: (BuildContext context) => new VisitScreen(),
        VISIT_FORM_FORM_SCREEN_PR: (BuildContext context) =>
            new DownloadScreen(),
        UPLOAD_SCREEN_PR: (BuildContext context) => new UploadScreen(),
        TRIAL_SCREEN_PR: (BuildContext context) => new TrialScreen(),
        TRIAL_FROM_SCREEN_PR: (BuildContext context) => new TrialFormPRScreen(),
        // TRANSACTION
        DISPLAY_SCREEN_PR: (BuildContext context) => new DisplayScreen(),
        STOK_SCREEN_PR: (BuildContext context) => new StokScreen(),
        PENJUALAN_SCREEN_PR: (BuildContext context) => new PenjualanScreen(),
        POSM_SCREEN_PR: (BuildContext context) => new PosmScreen(),
    REPORT_SCREEN_PR: (BuildContext context) => new ReportScreen(),
        //------ END PR
      };
}
