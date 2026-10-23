package example

import greeting.*

fun main() {
    val name: String = "World"

    println("Hello $name!")

    val doorman = Greeting()
    doorman.greet()

    val array = Array<Int>(5){0}
}

