# Compile Instructions

#### **Compile**

To be able to compile in linux you need to get into **src** directory in your terminal.
There you compile with 

> make

it will create the *program* executable file.

#### **Compile and run**

If you want to run it you put

  > make run

in your terminal and it will compile and run the *program* executable.

#### **Compile and run with arguments**

If you want to compile, and run with arguments, then you put

  > make ARGS="\<here your arguments\>" run

and it will run *program* executable with the arguments contained in the **ARGS** variable.

#### **Compile and run the test cases **

If you want to compile, and run with the test cases, then you put

  > make test

and it will run *program* executable with the test cases given in the [test/data](./test/data) folder.
They are all ran by the [test.sh](./test/test.sh) script.
