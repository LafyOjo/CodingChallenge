# CodingChallenge
Just revisiting basic concepts.

1. What is root class in swift
2. What is optionals
3. Different initialisers
4. Class vs struct
5. How do you write tests
6. Different App States
7. Escaping vs non escaping


Revision Questions

1.	In Swift, the "root class" refers to the ultimate base class from which all other classes inherit. In Swift, the root class is the NSObject class, which is defined in the Foundation framework. By default, all classes in Swift implicitly inherit from NSObject unless they explicitly inherit from another class.

2.	Optionals in Swift are a feature that allows variables or constants to either have a value or have no value at all. Optionals are used to handle situations where a value may be absent or where a value may exist. They are denoted by appending a question mark (?) to the type declaration. Optionals can be unwrapped to access their underlying value using conditional statements or optional binding.

3.	In Swift, there are several types of initializers:
•	Designated Initializers: These are the primary initializers for a class or struct. They fully initialize all properties introduced by that class or struct and call an appropriate superclass initializer to initialize any inherited properties.
•	Convenience Initializers: Convenience initializers are secondary initializers that provide a shortcut for common initialization patterns. They must call a designated initializer from the same class.
•	Failable Initializers: Failable initializers are initializers that can return nil if initialization fails. They are defined using the init? syntax and are useful when initialization conditions cannot be met.
•	Required Initializers: Required initializers are used in class inheritance. Subclasses must implement these initializers. They are defined using the required init syntax.

4.	The main difference between classes and structs in Swift is that classes are reference types, whereas structs are value types. Here are some key distinctions:
•	Inheritance: Classes support inheritance, while structs do not. A class can inherit from another class, but a struct cannot inherit from anything.
•	Memory Management: Classes use reference counting for memory management, whereas structs are copied when assigned to a new variable or passed to a function.
•	Mutability: Properties of a class can be changed even when the instance is declared as a constant (let). Structs, however, are value types, and their properties cannot be modified if the instance is declared as a constant.
•	Identity: Classes have a unique identity because they are reference types. Structs, being value types, are compared based on their values.

5.	Writing tests in Swift typically involves using the built-in testing framework called XCTest. Here's a high-level overview of how tests are written:
•	Create a new test case subclassing XCTestCase.
•	Write test methods that start with the word "test" and include the desired test logic.
•	Within the test methods, use assertion functions (XCTAssert) to check if the actual results match the expected results.
•	Use the XCTAssert family of functions to verify conditions and record failures.
•	Run the tests either through Xcode's Test Navigator or by invoking xcodebuild command-line tool.

6.	Different App States generally refer to the various states an application can be in during its lifecycle. In iOS, the common app states include:
•	Not Running: The app has not been launched or has been terminated by the system or the user.
•	Inactive: The app is running in the foreground but is not receiving events (e.g., when a phone call or system alert appears).
•	Active: The app is running in the foreground and receiving events.
•	Background: The app is in the background and executing code.
•	Suspended: The app is in the background but is not executing code. It may be removed from memory by the system to free up resources.

7.	Escaping and non-escaping are terms used in Swift to describe the lifetime and potential escape of closures passed as function parameters. Here's a brief explanation:
•	Non-Escaping Closures: By default, closures are non-escaping, which means they are executed within the context of the function in which they are passed. Non-escaping closures must be executed before the function returns.
•	Escaping Closures: An escaping closure is a closure that outlives the function it is passed to. It can be stored, retained, and executed after the function has returned. Escaping closures are typically used when the closure needs to be executed asynchronously or stored for later use.
When passing an escaping closure to a function, you need to explicitly mark it with @escaping in the function signature. This informs the compiler that the closure can escape the function's scope and should be treated accordingly.
![image](https://github.com/LafyOjo/CodingChallenge/assets/51814402/c5fe49de-e8bb-41ac-ada7-c04b8c8bb60f)
