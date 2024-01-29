class OnBoarding {
  final String title;
  final String description;
  final String image;

  OnBoarding({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnBoarding> onboardingContents = [
  OnBoarding(
    title: '',
    description: '',
    image: 'assets/images/Intructivo01.png',
  ),
  OnBoarding(
    title: 'Cultura en HD',
    description: 'Descripción: Vive la cultura, el arte y la música en alta definición. Descubre la intensidad de las emociones y la creatividad en cada pantalla, donde la realidad se fusiona con la imaginación',
    image: 'assets/images/pinceles.jpeg',
  ),
  OnBoarding(
    title: 'Atrapa la Esencia',
    description: 'Atrapa la esencia de la cultura y el arte en una experiencia que desafiará tus sentidos. Cada pantalla es una puerta a un universo fascinante que te dejará sin aliento.',
    image: 'assets/images/pinceles.jpeg',
  ),
  OnBoarding(
    title: 'Impacto Cultural',
    description: 'Prepárate para ser impactado. Nuestra aplicación redefine la experiencia cultural con pantallas que te sumergirán en una vorágine de emociones, colores y sonidos inolvidables. ¡Bienvenido al impacto cultural!',
    image: 'assets/images/pinceles.jpeg',
  ),
];