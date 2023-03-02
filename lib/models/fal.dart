// ignore: file_names

class Fal {
  final int Id;
  final String Poem;
  final String Interpretation;
  final String Title;
  Fal(this.Id, this.Poem, this.Interpretation, this.Title);

  List<String> get PoemParts {
    return Poem.split("\\r\\n");
  }
}
