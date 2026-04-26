class Tattoo
{
  final String id;
  final String imageUrl;
  final String title;
  final String artist;
  final String description;
  final List<String> tags;

  const Tattoo
  ({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.artist,
    required this.description,
    required this.tags
  });
}