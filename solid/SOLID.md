# SOLID

## S - Single Responsibility Principles (SRP)

### Definition

> A class should have only one reason to change, meaning it should have only one job or responsibility.

Mỗi class chỉ nên đảm nhận 1 công việc (a single part of the functionality provided by the software). Nếu nó đảm nhận nhiều hơn 1 responsibility, các responsibilities sẽ bị "coupled". Chỉ cần 1 thay đổi tới responsibility sẽ dẫn tới thay đổi ở nhiều class khác nhau.


### Example

### Questions

- Nếu mỗi class chỉ đảm nhận 1 nhiệm vụ, vậy sẽ sinh ra rất nhiều class, điều này có bất lợi gì không?
- Example thực tế trong code Rails/ real-life project?


## O - Open/ Closed Principle (OCP)

### Definition

> Software entities (classes, modules, functions, etc.) should be open for extension but closed for modification.

### Example

### Questions

- Có những loại software entities nào nữa =)) ?
- Closed for modification là như thế nào? Nếu thực sự cần sửa logic thì sao? 
- "Open for extension" là như thế nào? Extend là được phép thực hiện những hành động ntn?


## L - Liskov Substitution Principle (LSP)

### Definition

> Objects in a program should be replaceable with instances of their subtypes without altering the correctness of that program.

### Example


### Questions


## I - Interface Segregation Principle (ISP)

### Definition

> Many client-specific interfaces are better than one general-purpose interface.

### Example


### Questions


## D - Dependency Inversion Principle (DIP)

### Definition

> High-level modules should not depend on low-level modules. Both should depend on abstractions. Abstractions should not depend on details. Details should depend on abstractions.

### Notes

- Design is **all** about Dependency
  - If you refer to something ------------> you depend on it.
  - When the things you depend on change -> you must change.
- To avoid dependencies, your code should be: *loosely coupled, highly cohensive, easily composable, context independent*


### Questions

- Thế nào là high-level modules (complex logic?), low-level modules (utility features?)
- Abstractions gồm những cái gì? Interfaces là gì? Interfaces trong Rails/Ruby là như thế nào?
