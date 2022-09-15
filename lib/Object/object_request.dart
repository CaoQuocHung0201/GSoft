class Album {
  int? KHYC;
  int? GBDN;
  int? GBXL;
  int? GBTL;
  int? GBYC;
  int? YCDD;


  Album({
    this.KHYC,
    this.GBDN,
    this.GBXL,
    this.GBTL,
    this.GBYC,
    this.YCDD,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      KHYC: json['countKHYC'],
      GBDN: json['countGBDN'],
      GBXL: json['countGBXL'],
      GBTL: json['countGBTL'],
      GBYC: json['countGBYC'],
      YCDD: json['countYCDD'],
    );
  }
}