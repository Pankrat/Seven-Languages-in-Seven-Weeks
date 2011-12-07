val text = "Who cares about this anyway?"
val list = text.split(" ").elements.toList
val len = list.foldLeft(0)((total, str) => total + str.size)
assert (len == 24)
