package net.oostdam.snake.games;

public class Game {
    public String name;

    public Game(){
        // default constructor for serialization.
    }
    public Game(String name){
        this.name = name;
    }
}
