class PexelsEndPoints {
  static String url({String? query}) =>
      'https://api.pexels.com/v1/search?query=${query ?? 'people'}&per_page=50';
  static String apiKey =
      '563492ad6f91700001000001ee51c25f13714fdbba56913ea42f2d82';
}
