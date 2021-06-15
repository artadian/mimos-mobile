import 'package:mimos/helper/extension.dart';

class AppVersion {
	int id;
	int version_code;
	String version_name;
	String release_date;
	String release_log;
	String linkAndroid;
	String linkIos;
	bool force_update;
	bool all_user;

	AppVersion.fromJson(Map<String, dynamic> map)
			: id = map["id"].toString().toInt(),
				version_code = map["version_code"].toString().toInt(),
				version_name = map["version_name"].toString().clean(),
				release_date = map["release_date"].toString().clean(),
				release_log = map["release_log"].toString().clean(),
				linkAndroid = map["link_android"].toString().clean(),
				linkIos = map["link_ios"].toString().clean(),
				force_update = map["force_update"].toString().toBool(),
				all_user = map["all_user"].toString().toBool();

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['version_code'] = version_code;
		data['version_name'] = version_name;
		data['release_date'] = release_date;
		data['release_log'] = release_log;
		data['link_android'] = linkAndroid;
		data['link_ios'] = linkIos;
		data['force_update'] = force_update;
		data['all_user'] = all_user;
		return data;
	}
}