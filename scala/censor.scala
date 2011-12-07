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
    val words = text.split(" ").elements.toList
    val censored = words.map(word => alternatives(word))
    censored.foldLeft("")((text, word) => text + ' ' + word).trim
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
