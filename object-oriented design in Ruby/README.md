# Object-Oriented Design in Ruby

## 1. Object-Oriented Design
- Design Software bao gồm nhiều features. Features sẽ thay đổi. Thay đổi là điều không thể tránh khỏi.
- Để implement features thì cần sự tương tác giữa các *objects*. Các objects này sẽ gửi *messages* cho nhau, từ object này tới object kia. Điều này đòi hỏi là object A phải biết về object B. Điều này tạo ra *dependencies* giữa các object. Biết quá nhiều dẫn tới dependencies nhiều, trong khi cái dependencies này rất dễ bị thay đổi. 

> Object Oriented Design is about *managing dependencies*.

Quản lý các dependencies này, sao cho dễ thích ứng nhất với các thay đổi. 

- Design Principles: SOLID, DRY, LoD, ...
- Design Pattern

## 2. Designing Classes with a Single Resonsibility

- Thừa nhận rằng việc feature thay đổi => Code thay đổi là không thể tránh khỏi. Nhiệm vụ của chúng ta là tổ chức code sao cho nó dễ thích ứng với thay đổi nhất.
- Class mà có nhiều hơn 1 responsibility thì sẽ khó để tái sử dụng. Ví dụ class chứa logic code làm việc A, việc B. Tôi chỉ muốn tái sử dụng phần việc A, nhưng lại phải include của code của phần việc B vào => không hợp lý.

### Writing code that embraces change

#### Depend on Behavior, Not Data
- *Hide instance variables* 
	- Sử dụng `attr_accessor`, `attr_reader`, ... để truy cập/ access instance variables, thay vì việc dùng `@` (vd: `@chainring / @cog.to_f`). Cách này giúp ta hạn chế việc modify instance.
- *Hide data structures*
	- Xử lý data truyền vào khi khởi tạo riêng => readable
	- Messages sẽ được build trên readable attributes từ bước 1.

=> Thứ đưa ra ngoài cho các class khác nhìn được là public behaviors => Phần còn lại cần `hide` đi.

Giao tiếp giữa các object là messages. Nên cần define rõ được: Khi gửi đi một message, thứ tôi thực sự cần là gì? Logic cho phần này nên đặt ở đâu? Tôi có cần biết calculation logic của nó không?

#### Single Responsibility Everywhere
- Không chỉ áp dụng cho class, SR cần được áp dụng cho cả các methods.
	-  Expose previously hidden qualities => Clarify effect on the class
	- Avoid the need for comments
	- Encourage reuse => Small methods encourage coding behavior
	- Are easy to move to another class

- *Isolate Extra Responsibilities in Classes*

> [!note] Notes
>
> The path to changeable and maintainable object-oriented software begins with classes that have a single responsibility. Classes that do one thing isolate that thing from the rest of your application. This isolation allows change without consequence and reuse without duplication.

## 3. Managing Dependencies

Một object cần biết về: `personally` - chính nó, `inherits` - các methods được kế thừa, và `another objects who knows it` - các objects khác.

Một object cần biết về các objects khác (giống như việc bạn biết về những người xung quanh. Nếu không biết thì ta sẽ phải hỏi - tương tự việc check if rồi xử lý ...). Việc này tạo ra `dependencies`

### Recognizing Dependencies

- Một object có dependency khi nó biết:
	- The name of another class. Gear expects a class named Wheel to exist. - Tên class khác
	- The name of a message that it intends to send to someone other than self. Gear expects a Wheel instance to respond to diameter. - Tên function sẽ gọi sang class khác.
	- The arguments that a message requires. Gear knows that Wheel.new requires a rim and a tire. - arg của function sẽ gọi.
	- The order of those arguments. Gear knows that Wheel takes positional arguments and that the first should be rim, the second, tire. - Thứ tự của các args

> [!note] Notes
>
> ***Your design challenge is to manage dependencies so that each class has the fewest possible; a class should know just enough to do its job and not one thing more.***

Các object mà biết càng nhiều về nhau thì sẽ càng tạo ra nhiều dependency. Expect đẹp nhất thì trong các hàm public của 1 class, thì nên gửi tin nhắn tới `self` sẽ okela hơn là gọi ra bên ngoài.

### Writing Loosely Coupled Code

#### Inject Dependencies
- Gear không cần biết quá nhiều về Wheel. Càng biết nhiều, càng khó để tái sử dụng. Knew less, do more.
- Thay vì khởi tạo object Wheel ở trong Gear, ta sẽ truyền object vào trong Gear - Inject dependencies
	- Lúc này, Gear sẽ chỉ expect object truyền vào *có method diameter* là được, mà không cần quan tâm nó thuộc class nào, args khởi tạo ra sao.

#### Isolate Dependencies
- Trong thực tế, nếu làm việc với các hệ thống cũ (và rất hạn chế việc sửa lại code cũ), thì ta khó có thể làm theo cách Inject dependencies được. Tuy nhiên, vẫn có 1 cách khác để cải tiến code, đó là *cô lập phần dependencies này*.


- *Isolate Instance Creation*: Cô lập phần khởi tạo (dependency liên quan tới *class names*)
	- Đưa phần khởi tạo object vào trong hàm initialize
	- Hoặc: Tạo 1 function mới để khởi tạo wheel
	- => Cách này thực chất không giảm bớt sự phụ thuộc của Gear và Wheel, nhưng nó đã gom phần phụ thuộc vào 1 chỗ => cô lập chúng.

- *Isolate Vulnerable External Messages*: Cô lập phần gọi tới external messages.
	- Tách phần gọi ra bên ngoài `wheel.diameter` ra thành 1 method riêng.
	- Việc này chỉ nên thực hiện với những *message* mà có khả năng thay đổi - most vulnerable dependencies.

#### Remove Args Order Dependencies

- *Use Keyword Arguments*: Dùng dạng hash args, như thế sẽ k cần quan tâm tới thứ tự args =)) 
	- Using positional arguments requires less code today, but you pay for this decrease in volume of code with an increase in the risk that changes will cascade into dependents later.

- *Explicitly Define Default*: Adding a default renders the keyword args optional.

- *Isolate Multiparameter Initialization*
	- Nếu `Gear` là 1 phần của external interface. Eg: `SomeFramework::Gear`, mình không thay đổi được code của Gear, nên sẽ cố gắng cô lập nó bằng cách `wrap` phần khởi tạo object lại trong module `GearWrapper`.
	- Trong OOD, những module/class với nhiệm vụ tạo object khác, được gọi là `factories`

### Managing Dependency Direction

Dependencies always have a direction. Quyết định chiều phụ thuộc như thế nào cũng là 1 technique khó khăn.

#### Reversing Dependencies
- Hiện tại thì Gear đang phụ thuộc vào Wheel, thông qua hàm `diameter`. Tuy nhiên mình có thể revert dependencies direction, đổi cho Wheel phụ thuộc vào Gear bằng cách khởi tạo wheel bằng cách truyền vào `gear`, và tính `gear_inches` thông qua instance `gear` đó.
- Nếu application của mình không bao giờ thay đổi, thì okie, chọn dependencies theo direction nào cũng được :v Nhưng do app mình sẽ luôn thay đổi => nếu lựa chọn 'sai' direction, app sẽ rất khó để maintain.

#### Choosing Dependency Direction

> [!note] Notes
> 
> ***depend on things that change less often than you do.***

- Nên phụ thuộc vào thằng nào ít khi bị thay đổi hơn. Vì trong thực tế:
	- Nếu requirements thay đổi, thì 1 số class dễ phải thay đổi hơn các class khác. (ví dụ: `PurchaseService` logic thì dễ thay đổi hơn class `Order`)
	- Concrete class thì dễ thay đổi hơn Abstract classes. (Abstract classes define các hàm nhưng không implement logic cụ thể => Nó ít bị thay đổi hơn các class cụ thể)
	- Việc thay đổi 1 class mà có nhiều dependencies, sẽ khiến cho nhiều chỗ bị ảnh hưởng.

- *Understanding Likelihood of Change* - Tìm ra những objects dễ phải thay đổi.
	- Trong source code dự án, ta nên có "ranking" cho từng classes. Đâu là những classes *dễ bị thay đổi, đâu là class ít khi thay đổi*.  - [[INBOX/OOD Ranking classes|OOD Ranking classes]]
	- Ý tưởng là sẽ đi phân tích dựa trên: 
		- Domain Knowledge: Core business logic hoặc domain entities (models) thường ít bị thay đổi. Nhưng những class dạng application-specific/ infrastructure concerns thì dễ thay đổi hơn
		- External Dependencies, Technology Choices, Coupling and Cohesion (dễ thay đổi khi dependencies thay đổi), ...
- *Recognizing Concretions and Abstractions* - Tạo abstract class, vì nó stable hơn concrete class
	- Trong ví dụ phần trên, khi dùng dependency injection - truyền object `wheel` vào class Gear, ta đã khiến Gear phụ thuộc vào 1 thứ `abstract` hơn. Nó chỉ cần biết rằng object truyền vào có method `diameter` là được - Duck Typing
- *Avoiding Dependent-Laden Classes* - Luôn tránh việc để 1 objects phụ thuộc quá nhiều vào các object khác.



- *Finding the Dependencies That Matter*: Fill class vào metric: *likelihood of change* vs *number of dependents*

![[00 Meta/01 Attachments/Images Vault/Pasted image 20240715115923.png]]

> [!note] Notes
> 
> Dependency management is core to creating future-proof applications. Injecting dependencies creates loosely coupled objects that can be reused in novel ways. Iso- lating dependencies allows objects to quickly adapt to unexpected changes. Depend- ing on abstractions decreases the likelihood of facing these changes.
> 
> The key to managing dependencies is to control their direction. The road to maintenance nirvana is paved with classes that depend on things that change less often than they do.

## 4. Creating Flexible Interfaces

## 5. Reducing Costs with Duck Typing

## 6. Acquiring Behavior through Inheritance

## 7. Sharing Role Behavior with Modules

## 8. Combining Objects with Composition

## 9. Designing Cost-Effective Tests
