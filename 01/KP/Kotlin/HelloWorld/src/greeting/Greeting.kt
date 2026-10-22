package greeting

/*
class WorldGreeting(nameToGreet: String, numRepeats: Int){
    val name: String = nameToGreet;
    var repeats: Int = numRepeats;
 */
//constructor with parameter properties that are accessible outside the class via instance
class Greeting(val name: String = "World", var repeats: Int = 5){

    constructor(): this("World", 5){
        println("\"Greeting\" instance created with \"$name\", configured to repeat $repeats times")
    }

    fun greet(){
        for(i in 1..repeats){
            print("Greetings and ")
            println("Hello, $name!")
        }
    }
}