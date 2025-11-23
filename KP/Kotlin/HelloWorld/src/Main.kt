//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.

/*
class WorldGreeting(nameToGreet: String, numRepeats: Int){
    val name: String = nameToGreet;
    var repeats: Int = numRepeats;
 */

//constructor with parameter properties that are accessible outside the class via instance
class WorldGreeting(val name: String = "World", var repeats: Int = 5){

    fun greet(){
        for(i in 1..repeats){
            println("Hello, $name!")
        }
    }
}

fun main() {
    val doorman = WorldGreeting();
    doorman.greet();
}