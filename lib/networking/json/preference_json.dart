import 'package:afariat/networking/json/abstract_json_resource.dart';

class PreferenceJson extends AbstractJsonResource {
  bool optin;
  bool notifyOnMessage;
  bool notifyForStatistics;
  bool notifyForAdvertStatusChange;
  bool canalSms;
  bool notifyForAlerts;
  bool canalEmail;
  bool canalApp;

  PreferenceJson(
      {this.optin,
      this.notifyOnMessage,
      this.notifyForStatistics,
      this.notifyForAdvertStatusChange,
      this.canalSms,
      this.notifyForAlerts,
      this.canalEmail,
      this.canalApp});

  PreferenceJson.fromJson(Map<String, dynamic> json) {
    optin = json['optin'];
    notifyOnMessage = json['notify_on_message'];
    notifyForStatistics = json['notify_for_statistics'];
    notifyForAdvertStatusChange = json['notify_for_advert_status_change'];
    canalSms = json['notify_by_sms'];
    notifyForAlerts = json['notify_for_alerts'];
    canalEmail = json['notify_by_email'];
    canalApp = json['notify_by_app'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['optin'] = optin;
    data['notify_on_message'] = notifyOnMessage;
    data['notify_for_statistics'] = notifyForStatistics;
    data['notify_for_advert_status_change'] = notifyForAdvertStatusChange;
    data['notify_by_sms'] = canalSms;
    data['notify_for_alerts'] = notifyForAlerts;
    data['notify_by_email'] = canalEmail;
    data['notify_by_app'] = canalApp;
    return data;
  }
}
