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

### Understanding Interfaces

- Exposed methods: Methods nào sẽ được public ra ngoài, *cho objects nào dùng*. - public interface.

- The word interface can refer to a number of different concepts. Here the term is used to refer to the kind of interface that is within a class. Classes implement meth- ods; some of those methods are intended to be used by others, and these methods make up its public interface.
- Tạo interface. Các classes sẽ implements required methods - act like the interface kind of thing.

### Define Interfaces
- Tưởng tượng interfaces như 1 cái menu trong nhà hàng. Khách hàng nhìn thấy menu, nhưng không cần biết 1 món ăn sẽ được làm như thế nào. Họ chỉ cần như thế, nếu không thì họ sẽ phải biết từng món dùng nguyên liệu gì, ta nấu ra sao, ... -> không cần thiết.

- *Public Interfaces* - methods được public ra ngoài của 1 class
	- Reveal its primary responsibility.
	- Are expected to be invoked by others.
	- Will not change on a whim.
	- Are safe for others to depend on.
	- Are thoroughly documented in the tests.
- *Private Interfaces* - tất cả các methods còn lại
	- Handle implementation details.
	- Are not expected to be sent by other objects.
	- Can change for any reason whatsoever.
	- Are unsafe for others to depend on.
	- May not even be referenced in the tests.
- *Responsibilities, Dependencies, and Interfaces*
	- ***public methods should read like a description of responsibilities.***

### Find the Public Interface

> The design goal, as always, is to retain maximum future flexibility while writing only enough code to meet today’s requirements. Good public interfaces reduce the cost of unanticipated change; bad public interfaces raise it.

#### Constructing and Intention

- Từ yêu cầu của feature, cần detect ra được *domain objects*. Eg: Article, User, ContentPartner, Medium, ... - Stand for big, visible real-world things, representation in our database.
- Khi thiết kế, chúng ta chú ý vào domain objects, chúng sẽ là object wrap bên vòng ngoài. Tuy nhiên, core business logic là phần *messages* được gửi giữa những domain objects này.

#### Using Sequence Diagrams

- UML
- Case Study
	- (1) Customer send message to Trip: `.suitable_trip(on_date, of_difficulty, need_bike)` - Tìm chuyến du lịch dựa vào ngày, độ khó, và show ra chuyến đó có cần xe hay không.
		- Ở đây tồn tại 1 vấn đề: Đoạn tìm kiếm xe đạp không phải là nhiệm vụ của Trip
	- (2) Customer send 2 messages:
		- To Trip: `.suitable_trip(on_date, of_difficulty)` => Lấy ra list trips
		- To Bicycle: each trips: `.suitable_bike(trip_date, route_type)` 
		- => Trông có vẻ okie vì nó đã loại bỏ phần responsibilities từ Trip. Tuy nhiên, nó lại chuyển phần này sang cho Customer :v

#### Asking for "What" instead of Telling "How"

- Use Cases:
	- (1) Trip có method `bicycles`. Với mỗi bike, nó sẽ call sang `Mechanic` để: `clean_bicycle(bike)`, `pump_tires(bike)`, `lube_chain(bike)`, ...
		- Từ thiết kế này, ta thấy là: 
			- Trip có 1 public interfaces, có bao gồm method `bicycles`
			- Public interfaces của Mechanic bao gồm các methods: `clean_bicycle, pump_tire, lube_chain, check_brakes`
			- Trip expect là object mechanic phải respond lại các methods trên.
		- Thiết kế này làm Trip biết quá nhiều về Mechanic, nên nó sẽ luôn phải thay đổi nếu Mechanic có thay đổi/ mở rộng.
	- (2) Đổi lại thiết kế: Đưa phần prepare từ Trip sang Mechanic, sau đó Mechanic public 1 hàm `prepare_bicycle(bike)` sang cho Trip. Logic detail được đưa lại về Mechanic
		- Thiết kế bao gồm:
			- Trip có 1 public interface, chứa method `bicycles`
			- Mechanic chứa 1 public interfaces, có method `prepare_bicycle`
			- Trip expect object mechanic phải response lại method `prepare_bicycle`

=> Trip asking for "WHAT" instead of "HOW" Mechanic prepare bike.

#### Seeking Context Independence
- Simple Context - expect few things from their surrounding.
- Với usecase bên trên, ta có thể đổi thành:
	- (3) What Trip wants - `prepare_trip` => Dùng Dependencies Injection để truyền `trip` vào Mechanic, sau đó Mechanic gọi lấy `bicycles`, rồi tự chuẩn bị `prepare_bike` trong class mechanic luôn.
		- The public interface for Trip includes bicycles.
		- The public interface for Mechanic includes prepare_trip and perhaps prepare_bicycle.
		- Trip expects to be holding onto an object that can respond to prepare_trip.
		- Mechanic expects the argument passed along with prepare_trip to respond to bicycles.

#### Trusting Other Objects
- 3 cách design bên trên thể hiện cho 3 câu nói: 
	- (1) - I know what I want, and I know how you do it.
	- (2) - I know what I want, and I know what you do.
	- (3) - I know what I want, and I trust you to do your part.

#### Using Messages to Discover Objects
#### Creating a Message-Based Application

### Writing Code that Puts Its Best (Inter)Face Forward

> Think about interfaces. Create them intentionally. It is your interfaces, more than all of your tests and any of your code, that define your application and determine its future.

Chương này hướng dẫn về rules of thumb khi create interfaces.

#### Create Explicit Interfaces
- Every time you create a class, declare its interfaces. Methods in the public interface should:
	- Be explicitly identified as such.
	- Be more about what than how.
	- Have names that, insofar as you can anticipate, will not change.
	- Prefer keyword arguments.
- Sử dụng các keyword: `public`, `protected`, `private` khi có thể.

#### Honor the Public Interfaces of Others
- Chỉ sử dụng public thôi. Hạn chế tối đa việc call private methods của external framework/class/...

#### Exercise Caution When Depending on Private Interfaces
- Khi ta buộc phải call private interfaces, hãy áp dụng các quy tắc Isolate như ở Chương 3.

#### Minimize Context

> Construct public interfaces with an eye toward minimizing the context they require from others. Keep the what versus how distinction in mind; create public methods that allow senders to get what they want without knowing how your class implements its behavior.

### The Law of Demeter

> Demeter restricts the set of objects to which a method may send messages; it prohib- its routing a message to a third object via a second object of a different type. Demeter is often paraphrased as “only talk to your immediate neighbors” or “use only one dot.”

Không send message qua nhiều object khác nhau, mà dữ liệu trả về lại thuộc type khác nhau. Tốt nhất chỉ nên "use only one dot". (not: `customer.bicycle.wheel.tire`)

Sử dụng `delegate` để tránh vi phạm Law of Demeter.


> [!note] Notes
> 
> Object-oriented applications are defined by the messages that pass between objects. This message passing takes place along “public” interfaces; well-defined public inter- faces consist of stable methods that expose the responsibilities of their underlying classes and provide maximal benefit at minimal cost.
> 
> Focusing on messages reveals objects that might otherwise be overlooked. When messages are trusting and ask for what the sender wants instead of telling the receiver how to behave, objects naturally evolve public interfaces that are flexible and reusable in novel and unexpected ways.


## 5. Reducing Costs with Duck Typing

### Understanding Duck Typing
#### Overlooking the Duck
#### Compounding the Problem
- Count the number of new dependencies khi muốn refactor =)) 
	- specific classes, explicit names of those classes; the names of the messages that each class understands, along with the args that those messages require.

#### Finding the Duck
- Nhận dạng qua `case ... when`, find the duck, and implement 'quack' method.

#### Consequences of Duck Typing
- Code cụ thể (check type, class và gọi method và args tương ứng) có ưu điểm là dễ hiểu, nhưng sẽ nguy hiểm khi ta mở rộng. Code theo kiểu duck typing thì hướng abstract hơn, tuy nó 'khó hiểu' hơn 1 chút nhưng một khi hiểu, sẽ rất dễ để mở rộng với type mới sau này. 

> This tension between the costs of concretion and the costs of abstraction is fundamental to object-oriented design.

### Writing Code that Relies on Ducks

#### Recognizing Hidden Ducks ⭐⭐
- *Case Statements that Switch on Class*
	- Khi thấy `case ... when` mà checking Class => Khả năng đây chính là hidden ducks

- *kind_of? and is_a?*
	- 2 hàm này dùng để check class của object hiện tại => Cũng là dấu hiệu nhận biết hidden ducks. Eg: `preparer.kind_of?(Mechanic)`

- *responds_to?*
	- Hàm này dùng để check 1 object có phản hồi lại method xxx không. eg: `preparer.respond_to?(:prepare_bicycles)`
	- Mặc dù cách check này đã remove dependencies vào Class name, nhưng đoạn code trên vẫn không khác gì việc checking class.

#### Placing Trust in Your Ducks

> Flexible applications are built on objects that operate on trust; it is your job to make your objects trustworthy. When you see these code patterns, concentrate on the offending code’s expectations and use those expectations to find the duck type. Once you have a duck type in mind, define its interface, implement that interface where necessary, and then trust those implementers to behave correctly.

#### Choosing Your Ducks Wisely

- Mục đích sau cùng của OOD là giảm cost. Nếu sử dụng duck type mà giảm unstable dependencies thì hãy làm =)) (Tác giả có đưa ra ví dụ hàm `find_by_ids` trong Rails, vẫn dùng `when 0, when 1` bình thường. Lý do là dependencies của nó là Array và NilClass => 2 classes này đều rất stable, nên k cần phải dùng duck type trong case này)

### Conquering a Fear of Duck Typing

#### Subverting Duck Types with Static Typing
- Dynamic Typing linh hoạt, nhưng cũng có nhược điểm của nó, do ta không kiểm soát được thứ gì "thực sự" ở trong 1 array. (ví dụ: `[1, "hello", {a: 2}]`)

> Duck typing provides a way out of this trap. It removes the dependencies on class and thus avoids the subsequent type failures. It reveals stable abstractions on which your code can safely depend.

#### Static versus Dynamic Typing

#### Embracing Dynamic Typing

- Duck Typing sẽ thể hiện được tối đa sức mạnh ở những ngôn ngữ dynamic typing. 
- Nếu cần, hãy sử dụng handle nil pattern để hạn chế lỗi raise không mong muốn khi sử dụng duck typing ở những ngôn ngữ dynamic typing.

> [!note] Notes
> 
> Messages are at the center of object-oriented applications, and they pass among objects along public interfaces. Duck typing detaches these public interfaces from specific classes, creating virtual types that are defined by what they do instead of by who they are.
> 
> Duck typing reveals underlying abstractions that might otherwise be invisible. Depending on these abstractions reduces risk and increases flexibility, making your application cheaper to maintain and easier to change.



## 6. Acquiring Behavior through Inheritance


> Well-designed applications are constructed of ***reusable code***. Small, trustworthy self- contained objects with ***minimal context, clear interfaces, and injected dependencies are inherently reusable***.

### Understanding Classical Inheritance

- Kế thừa, đơn giản là kiểu abstraction and *automatic message delegation* => forwarding path for not-understood messages.

### Recognizing Where to Use Inheritance

- Concrete class basic thường ok, nhưng sẽ phình to nếu như add thêm xử lý cho các type khác nhau.

- *Embedding Multiple Types*: Add thêm các xử lý type khác
- *Finding the Embedded Types*: Chú ý tới các key như `type/category/check class_name`. Đây là kiểu related types that share common behavior but differ along some dimension.

- Kế thừa, gắn kết 2 objects trong 1 mối quan hệ, mà nếu object đầu tiên nhận tin nhắn, mà không hiểu tin nhắn đó, thì có thể forwards, hoặc delegates tin nhắn đó cho object thứ 2.

### Misapplying Inheritance

### Finding the Abstraction

- 2 rules trong Kế thừa:
	- Objects mà mình đang modeling phải thực sự có quan hệ cha-con (generalization-specialization relationship)
	- You must use the correct coding techniques.

#### Creating an Abstract Superclass

- Tạo class cha là Abstract Class. Tạo ra abstract class để các class con có thể kế thừa.

> Abstract classes exist to be subclassed. This is their sole purpose. They provide a common repository for behavior that is shared across a set of subclasses—subclasses that in turn supply specializations.

- Kế thừa sẽ sinh ra cost (tạo thêm các class mới, và nguy cơ phải custom lại các class con khá nhiều). Các tốt nhất để minimize cost đó là maximize cơ hội để tạo được abstraction trước khi để các class con depend on the abstraction.

> A decision to proceed with the hierarchy accepts the risk that you may not yet have enough information to identify the correct abstraction.
> ...
> You should wait, if you can, but don’t fear to move forward based on two concrete cases if this seems best.

- *Promoting Abstract Behavior*
	- ***push-everything-down-and-then-pull-some-things-up strategy is an important part of this refactoring.***: Đưa hết behavior của class cha xuống class con, sau đó lại promote behavior chung lên class cha =))) 
	- Promote kiểu này thì nếu có fail (do detect sai behavior để promote) cũng sẽ gây hậu quả nhỏ, do phần lớn code đã nằm ở class con rồi.
	- Nếu tách code dần từ class cha xuống class con, thì có khả năng behavior của class cha không thể áp dụng với mọi class con. Điều này vi phạm basic rule của Kế thừa: *Subclass must be truly specializations of their superclasses.* - Có vẻ giống nguyên tắc LISKOV

> [!note] Notes
>
> The general rule for refactoring into a new inheritance hierarchy is to arrange code so that you can promote abstractions rather than demote concretions.


- *Using the template method pattern*
	- Superclass thường sẽ define các templates - basic structure. Các subclass sẽ nhìn vào basic structure đó để implement custom logic.
	- Một khi đã define template structure, bạn *phải* force tất cả các class con implement behavior theo structure đó. Cách tốt nhất là `raise NotImplementedError` trong class cha.

### Managing Coupling between Superclasses and Subclasses

- Chia nhỏ methods, implement abstract / template methods structure, các class con implement chúng. Nghe có vẻ okie. Nhưng ở đây tồn tại 1 vấn đề: Các class con vẫn đang gọi "super" để call lại implement của class cha. => Require Class con phải biết cách interact với class cha. Việc này tạo thêm dependencies, *force tất cả các subclass mới đều phải gọi super để call implement của class cha*.
	- Việc này push algorithm down into the subclasses, forcing each to explicitly send 'super' to participate => Duplicate code (đoạn gọi super) giữa các class con.
	- Ngoài ra, khi lập trình viên khác implement mới 1 subclass, mặc dù họ đã tạo ra ***correct specializations*** but can easily forget to send super => Vẫn lỗi, dù tôi đã implement folow abstract behavior trong class cha.

- *Decoupling Subclasses Using Hook Messages* 👍
	- Để tránh việc gọi `super` trong subclasses, ta có thể implement hook messages.
	- Ví dụ: `post_initialize(opts)`, `local_spares` => Các methods này được implement trong subclasses.


### Summary

- Kế thừa: giải quyết các vấn đề liên quan tới related types - những thằng share với nhau nhiều behavior chung, nhưng lại khác nhau ở 1 số chỗ. Nó cho phép ***isolate shared code, implement comment algorithms in an abstract class, while providing a structure that permits subclasses to contribute specializations.***

- Cách tốt nhất để tạo ra 1 abstract superclass đó là: 
	- Push hết code xuống subclass. Sau đó pull nó dần lên superclass.
	- Xác định correct abstraction sẽ dễ hơn nếu ta có ít nhất 3 concrete classes.

- Abstract superclasses use the template method pattern to invite inheritors to supply specializations, and they use hook methods to allow these inheritors to contrib- ute these specializations without being forced to send super. Hook methods allow subclasses to contribute specializations without knowing the abstract algorithm. They remove the need for subclasses to send super and therefore reduce the coupling between layers of the hierarchy and increase its tolerance for change.


## 7. Sharing Role Behavior with Modules

## 8. Combining Objects with Composition

## 9. Designing Cost-Effective Tests
