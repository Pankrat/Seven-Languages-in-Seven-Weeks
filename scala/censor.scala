import collection.mutable.HashMap


trait Censor {
  val alternatives = new HashMap[String, String] {
    override def default(key: String) = key
  }

  alternatives += (
    "Shoot" -> "Pucky",
    "Darn" -> "Beans",
    "Bastard" -> "Dude"
  )

  def censor(text: String): String = {
    val words = text.split(" ")
    val censored = words.map(word => alternatives(word))
    censored.mkString(" ")
  }

  def loadSwearWords(filename: String) {
    alternatives.clear()
    val file = scala.io.Source.fromFile(filename)
    val mapping = file.getLines.map(line => line.split(";"))
    mapping.foreach(tuple => alternatives += (tuple(0) -> tuple(1)))
    file.close()
  }
}


class BlasphemingBarry extends Censor {
  def talk(text: String) {
    println(text)
  }

  def talk_to_chris(text: String) {
    talk(censor(text))
  }
}

val original = "Shoot the Darn Bastard"
val barry = new BlasphemingBarry
barry.talk(original)
barry.talk_to_chris(original)
assert (barry.censor(original) == "Pucky the Beans Dude")

val swearforreal = "fucking Bastard"
barry.loadSwearWords("swearwords.txt")
barry.talk(swearforreal)
barry.talk_to_chris(swearforreal)
assert (barry.censor(swearforreal) == "frakking Bastard")
