import 'package:flutter_test_project/device_type.dart';

class LineChartAppearanceData {

  double aspectRatio;

  LineChartAppearanceData({
    int singularSize,
  }) {

    bool isPhone = DeviceType().isPhone;

    if(isPhone && singularSize == 4) {
      this.aspectRatio = 1;
      return;
    }
    //is verticalTile and phone
    if (singularSize == 2 && isPhone) {
      this.aspectRatio = 2;
      return;
    }
    //is only phone
    else if (isPhone) {
      this.aspectRatio = 1;
      return;
    }
    //is verticalTile but not phone
    else if (singularSize == 2) {
      this.aspectRatio = 2;
      return;
    }
    else
      aspectRatio = 1;
    return;
  }
}
