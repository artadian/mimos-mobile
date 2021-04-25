import 'package:flutter/foundation.dart';

const BASE_URL =
    "https://api.wim-bms.com/apimimos-dev/index.php";
//    "http://192.168.43.225/apimimos/index.php";
//    : "http://172.27.8.241/apimimos/index.php";

//const BASE_URL = kReleaseMode
//    ? "https://api.wim-bms.com/apimimos/index.php"
//    : "https://api.wim-bms.com/apimimos/index.php";

const BASE_URL_API = "$BASE_URL/api";

const URL_APP_VERSION = "$BASE_URL_API/App_version/getVersion";
const URL_PULL_CUSTOMER_PR = "$BASE_URL_API/Customer/customerbyvisitday";
const URL_PULL_LOOKUP_PR = "$BASE_URL_API/Lookup/getByUser";
const URL_PULL_INTRODEAL_PR = "$BASE_URL_API/Introdeal/getBySalesOffice";
const URL_PULL_BRAND_COMPETITOR_PR = "$BASE_URL_API/Master_data/getBrandCompBySalesOffice";
const URL_PULL_MATERIAL_PRICE = "$BASE_URL_API/Material_price/getBySalesOffice";

const URL_PULL_VISIT = "$BASE_URL_API/Visit/getByDate";
const URL_PULL_STOCK = "$BASE_URL_API/Stock/getByDate";
const URL_PULL_STOCK_DETAIL = "$BASE_URL_API/Stock_detail/getByHead";
const URL_PULL_SELLIN = "$BASE_URL_API/Sellin/getByDate";
const URL_PULL_SELLIN_DETAIL = "$BASE_URL_API/Sellin_detail/getByHead";
const URL_PULL_VISIBILITY = "$BASE_URL_API/Visibility/getByDate";
const URL_PULL_VISIBILITY_DETAIL = "$BASE_URL_API/Visibility_detail/getByHead";
const URL_PULL_POSM = "$BASE_URL_API/Posm/getByDate";
const URL_PULL_POSM_DETAIL = "$BASE_URL_API/Posm_detail/getByHead";
const URL_PULL_TRIAL = "$BASE_URL_API/Trial/getByDate";
const URL_PULL_CUST_INTRODEAL = "$BASE_URL_API/Customer_introdeal/getByUser";

/// Upload Data
// Visit
const URL_PUSH_VISIT = "$BASE_URL_API/Visit/add";
const URL_UPDATE_VISIT = "$BASE_URL_API/Visit/update";
const URL_DELETE_VISIT = "$BASE_URL_API/Visit/delete_flag";
// Stock
const URL_PUSH_STOCK = "$BASE_URL_API/Stock/add";
const URL_UPDATE_STOCK = "$BASE_URL_API/Stock/update";
const URL_DELETE_STOCK = "$BASE_URL_API/Stock/delete_flag";
const URL_PUSH_STOCK_DETAIL = "$BASE_URL_API/Stock_detail/add";
const URL_UPDATE_STOCK_DETAIL = "$BASE_URL_API/Stock_detail/update";
const URL_DELETE_STOCK_DETAIL = "$BASE_URL_API/Stock_detail/delete_flag";
// Sellin
const URL_PUSH_SELLIN = "$BASE_URL_API/Sellin/add";
const URL_UPDATE_SELLIN = "$BASE_URL_API/Sellin/update";
const URL_DELETE_SELLIN = "$BASE_URL_API/Sellin/delete_flag";
const URL_PUSH_SELLIN_DETAIL = "$BASE_URL_API/Sellin_detail/add";
const URL_UPDATE_SELLIN_DETAIL = "$BASE_URL_API/Sellin_detail/update";
const URL_DELETE_SELLIN_DETAIL = "$BASE_URL_API/Sellin_detail/delete_flag";
// POSM
const URL_PUSH_POSM = "$BASE_URL_API/Posm/add";
const URL_UPDATE_POSM = "$BASE_URL_API/Posm/update";
const URL_DELETE_POSM = "$BASE_URL_API/Posm/delete_flag";
const URL_PUSH_POSM_DETAIL = "$BASE_URL_API/Posm_detail/add";
const URL_UPDATE_POSM_DETAIL = "$BASE_URL_API/Posm_detail/update";
const URL_DELETE_POSM_DETAIL = "$BASE_URL_API/Posm_detail/delete_flag";
// Visibility
const URL_PUSH_VISIBILITY = "$BASE_URL_API/Visibility/add";
const URL_UPDATE_VISIBILITY = "$BASE_URL_API/Visibility/update";
const URL_DELETE_VISIBILITY = "$BASE_URL_API/Visibility/delete_flag";
const URL_PUSH_VISIBILITY_DETAIL = "$BASE_URL_API/Visibility_detail/add";
const URL_UPDATE_VISIBILITY_DETAIL = "$BASE_URL_API/Visibility_detail/update";
const URL_DELETE_VISIBILITY_DETAIL =
    "$BASE_URL_API/Visibility_detail/delete_flag";
// Trial
const URL_PUSH_TRIAL = "$BASE_URL_API/Trial/add";
const URL_UPDATE_TRIAL = "$BASE_URL_API/Trial/update";
const URL_DELETE_TRIAL = "$BASE_URL_API/Trial/delete_flag";
// Customer Introdeal
const URL_PUSH_CUST_INTRODEAL = "$BASE_URL_API/Customer_introdeal/add";
const URL_UPDATE_CUST_INTRODEAL = "$BASE_URL_API/Customer_introdeal/update";
const URL_DELETE_CUST_INTRODEAL = "$BASE_URL_API/Customer_introdeal/delete";
