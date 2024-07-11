<?php

// Define an abstract class
abstract class Animal {
  // abstract method makeSoud with no body
  abstract public function makeSound();

  public function move() {
    echo "The animal moves";
  }
}

// Dog class inherits the Animal class
class Dog extends Animal {
  // define abstract method
  public function makeSound() {
    echo "Woof";
  }
}

// Cat class inherits the Animal class
class Cat extends Animal {
  // define abstract method
  public function makeSound() {
    echo "Meow";
  }
}

?>
