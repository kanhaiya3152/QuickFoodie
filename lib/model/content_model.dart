class OnboardingContent {
  OnboardingContent(
      {
      required this.description,
      required this.image,
      required this.title,
      });
  String image;
  String title;
  String description;
}

List<OnboardingContent> content = [
  OnboardingContent(
    description: 'Pick your food from Our menu\n        More than 35 times', 
    image: 'assets/screen1.png', 
    title: 'Select from our\n    Best Menu '),
  OnboardingContent(
    description: 'You can pay cash on delivery and\n                  card payment',
    image: 'assets/screen2.png',
    title: 'Easy and Online payment'
  ),
  OnboardingContent(
    description: 'Deliver your food at your\n              Doorstep',
    image: 'assets/screen3.png',
    title: 'Quick Delivery at \n   Your Doorstep'
  ),
];
