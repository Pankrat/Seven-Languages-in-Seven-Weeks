object Rules {

    val Indices = List(
        (0, 1, 2), (3, 4, 5), (6, 7, 8),
        (0, 3, 6), (1, 4, 7), (2, 5, 8),
        (0, 4, 8), (2, 4, 6)
    )

    val Tie = '-'
    val Unfinished = ' '
    val Players = "xo"

    def hasWon(x: Char, y: Char, z: Char): Boolean = {
        (x == y && y == z && (Players.contains(x)))
    }

}

class Game(setting: String) {

    val board = setting.toCharArray()

    def winner: Char = {
        for((i, j, k) <- Rules.Indices)
            if (Rules.hasWon(board(i), board(j), board(k)))
                return board(i)
        if (setting.contains(Rules.Unfinished))
            return Rules.Unfinished
        return Rules.Tie
    }

}

assert (new Game("xxxooxoo ").winner == 'x')
assert (new Game("xoxooxxo ").winner == 'o')
assert (new Game(" oxoxoxox").winner == 'x')
assert (new Game("xoxooxxxo").winner == Rules.Tie)
assert (new Game("         ").winner == Rules.Unfinished)
