import 'dart:math';

class TileSize {

  const TileSize(this.width, this.height);

  final int width;
  final int height;

  static List<TileSize> createSizes(int count) {
    Random rnd = new Random();
    return new List.generate(count,
            (i) => new TileSize((rnd.nextInt(500) + 200), rnd.nextInt(800) + 200));
  }
}