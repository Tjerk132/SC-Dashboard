class LineChartAppearanceData {

  late double aspectRatio;

  LineChartAppearanceData({
    required int factor,
  }) {

    bool isPhone = false; //todo: determine via stacked

    this.aspectRatio = isPhone ? 0.8 : factor == 2 ? 2 : 1;

    // if(isPhone && singularSize == 4) {
    //   this.aspectRatio = 1;
    // }
    // //is verticalTile and phone
    // else if (singularSize == 2 && isPhone) {
    //   this.aspectRatio = 2;
    // }
    // //is only phone
    // else if (isPhone) {
    //   this.aspectRatio = 1;
    // }
    // //is verticalTile but not phone
    // else if (singularSize == 2) {
    //   this.aspectRatio = 2;
    // }
    // else
    //   aspectRatio = 1;
  }
}
