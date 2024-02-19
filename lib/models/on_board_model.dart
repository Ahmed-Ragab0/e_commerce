class OnBoardModel {
  final String image;
  final String title;
  final String desc;

  OnBoardModel({
    required this.image,
    required this.title,
    required this.desc,
  });
}

List<OnBoardModel> onBoardItems = [
  OnBoardModel(
      image: 'assets/images/onboard.png', title: 'Screen 1', desc: 'screen 1'),
  OnBoardModel(
      image: 'assets/images/onboard.png', title: 'Screen 2', desc: 'screen 2'),
  OnBoardModel(
      image: 'assets/images/onboard.png', title: 'Screen 3', desc: 'screen 3'),
];
