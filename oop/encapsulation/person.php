<?php

class Person {
  // private properties which can only be accessed within the class
  private $name;
  private $age;

  public function __construct($name, $age) {
    $this->name = $name;
    $this->age = $age;
  }

  public function getName() {
    return $this->name;
  }

  public function setName($name) {
    $this->name = $name
  }

  public function getAge() {
    return $this->age;
  }

  public function setAge($age) {
    if ($age < 18) {
      throw new Exception("Person is not old enough");
    }
    $this->age = $age;
  }
}

?>
