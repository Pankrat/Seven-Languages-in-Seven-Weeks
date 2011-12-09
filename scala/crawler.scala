/*
 * Requires TagSoup, run with:
 * scala -cp /usr/share/java/tagsoup-1.2.jar crawler.scala
 */

import java.nio.charset.MalformedInputException
import scala.actors._
import scala.io.Source
import scala.xml.XML
import Actor._


class Page(url: String) {

  val encodings = List("ISO-8859-15", "UTF-8")
  val page = load

  def load: String = {
    for(enc <- encodings) {
      try { 
        return Source.fromURL(url, enc).mkString
      } 
      catch { 
        case e: MalformedInputException =>
          println("Malformed input [" + url + "]: " + enc)
      }
    }
    return ""
  }


  // Use TagSoup for robust HTML parsing
  def parse = {
    val parserFactory = new org.ccil.cowan.tagsoup.jaxp.SAXFactoryImpl
    val parser = parserFactory.newSAXParser()
    val source = new org.xml.sax.InputSource(url)
    val adapter = new scala.xml.parsing.NoBindingFactoryAdapter
    adapter.loadXML(source, parser)
  }


  def anchors: Int = {
    val xml = parse
    var cnt = 0
    (xml \\ "a").foreach { anchor => 
      //println(anchor \ "@href") 
      cnt += 1
    }
    cnt
  }

  def size: Int = page.length
}


val urls = List(
  "http://www.amazon.com/",
  "http://www.twitter.com/",
  "http://www.google.com/",
  "http://www.bbc.co.uk/"
)


def timeMethod(method: () => Unit) = {
  val start = System.nanoTime
  method()
  val end = System.nanoTime
  println("Method took " + (end - start)/1000000000.0 + " seconds.")
}


def getPageSizeSequentially() = {
  for(url <- urls) {
    val page = new Page(url)
    println(url +  " links=" + page.anchors)
  }
}


def loadPage(url: String) = {
  val page = new Page(url)
  page
}


def getPageSizeConcurrently() = {
  val caller = self
  for(url <- urls) {
    actor { caller ! (url, loadPage(url).anchors) }
  }
  for(i <- 1 to urls.size) {
    receive {
      case (url, links) => println(url + " links=" + links)
    }
  }
}

println("Sequential run...")
timeMethod { getPageSizeSequentially }

println("Concurrent run...")
timeMethod { getPageSizeConcurrently }
