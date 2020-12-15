import 'package:flutter/material.dart';

import 'package:mimos/Constant/Constant.dart';
import 'package:mimos/FL/Screen/downloadscreenFL.dart';
import 'package:mimos/FL/Screen/trialscreenFL.dart';
import 'package:mimos/FL/Screen/uploadscreenFL.dart';
import 'package:mimos/PR/screen/transaction/display/display_pr_screen.dart';
import 'package:mimos/PR/screen/transaction/penjualan/penjualan_pr_screen.dart';
import 'package:mimos/PR/screen/transaction/posm/posm_pr_screen.dart';
import 'package:mimos/PR/screen/transaction/stok/form/stok_form_pr_screen.dart';
import 'package:mimos/PR/screen/transaction/stok/stok_pr_screen.dart';
import 'package:mimos/PR/screen/trial/form/trial_form_pr_screen.dart';
import 'package:mimos/PR/screen/trial/trial_pr_screen.dart';
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
import 'package:mimos/PR/screen/download/download_pr_screen.dart';
import 'package:mimos/PR/screen/upload/upload_pr_screen.dart';
import 'package:mimos/PR/screen/visit/visit_pr_screen.dart';

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
        DOWNLOAD_SCREEN_PR: (BuildContext context) => new DownloadPRScreen(),
        VISIT_SCREEN_PR: (BuildContext context) => new VisitPRScreen(),
        VISIT_FORM_FORM_SCREEN_PR: (BuildContext context) =>
            new DownloadPRScreen(),
        UPLOAD_SCREEN_PR: (BuildContext context) => new UploadPRScreen(),
        TRIAL_SCREEN_PR: (BuildContext context) => new TrialPRScreen(),
        TRIAL_FROM_SCREEN_PR: (BuildContext context) => new TrialFormPRScreen(),
        // TRANSACTION
        DISPLAY_SCREEN_PR: (BuildContext context) => new DisplayPRScreen(),
        STOK_SCREEN_PR: (BuildContext context) => new StokPRScreen(),
        PENJUALAN_SCREEN_PR: (BuildContext context) => new PenjualanPRScreen(),
        POSM_SCREEN_PR: (BuildContext context) => new PosmPRScreen(),
        STOK_FROM_SCREEN_PR: (BuildContext context) => new StokFormPRScreen(),
        //------ END PR
      };
}
