import 'package:flutter/foundation.dart';

const BASE_URL = kReleaseMode
    ? "https://api.wim-bms.com/apimimos/index.php"
    : "http://192.168.43.225/apimimos/index.php";

//const BASE_URL = kReleaseMode
//    ? "https://api.wim-bms.com/apimimos/index.php"
//    : "https://api.wim-bms.com/apimimos/index.php";

const BASE_URL_API = "$BASE_URL/api";

const URL_PULL_MATERIAL_PR = "$BASE_URL_API/Material/materialFL";
const URL_PULL_CUSTOMER_PR = "$BASE_URL_API/Customer/customerbyvisitday";
const URL_PULL_LOOKUP_PR = "$BASE_URL_API/Umum/lookup";
const URL_PULL_INTRODEAL_PR = "$BASE_URL_API/Material/introDealTFbyUseridbyTgl";
const URL_PULL_BRAND_COMPETITOR_PR = "$BASE_URL_API/Frontliner/brandcompetitor";
const URL_PULL_MATERIAL_PRICE = "$BASE_URL_API/Material_price/getBySalesOffice";

const URL_PULL_VISIT = "$BASE_URL_API/Visit/getByDate";
const URL_PULL_STOCK = "$BASE_URL_API/Stock/getByDate";
const URL_PULL_STOCK_DETAIL = "$BASE_URL_API/Stock_detail/getByHead";
const URL_PULL_SELLIN = "$BASE_URL_API/Sellin/getByDate";
const URL_PULL_SELLIN_DETAIL = "$BASE_URL_API/Sellin_detail/getByHead";

/// Upload Data
const URL_PUSH_VISIT = "$BASE_URL_API/Visit/add";
const URL_UPDATE_VISIT = "$BASE_URL_API/Visit/update";
// Stock
const URL_PUSH_STOCK = "$BASE_URL_API/Stock/add";
const URL_PUSH_STOCK_DETAIL = "$BASE_URL_API/Stock_detail/add";
const URL_UPDATE_STOCK_DETAIL = "$BASE_URL_API/Stock_detail/update";
const URL_DELETE_STOCK_DETAIL = "$BASE_URL_API/Stock_detail/delete_flag";
// Sellin
const URL_PUSH_SELLIN = "$BASE_URL_API/Sellin/add";
const URL_PUSH_SELLIN_DETAIL = "$BASE_URL_API/Sellin_detail/add";
const URL_UPDATE_SELLIN_DETAIL = "$BASE_URL_API/Sellin_detail/update";
const URL_DELETE_SELLIN_DETAIL = "$BASE_URL_API/Sellin_detail/delete_flag";
