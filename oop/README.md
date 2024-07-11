# OOP 

## Abstraction - Trừu tượng 

![](https://logicmojo.com/assets/dist/new_pages/images/abstraction.jpg)

### Definition

Trừu tượng là quá trình mô hình hóa, cố gắng mô tả một đối tượng/ hành động/ hiện tượng trong thế giới thực vào trong code.

Ví dụ: Con chó có 4 chân, xe 4 bánh, người thì có hành động ăn, uống, đi lại, ...

### Questions

- Tại sao chúng ta cần tạo ra abstract class, sau đó là các class con và cho kế thừa class abstract? Trong khi ta có thể tạo ra class con luôn, miễn là vẫn đảm bảo class con luôn có đủ method cần thiết?
	- *Common Interface*: Abstract classes cho phép chúng ta define common interface. Nó ensure lại rằng các subclass sẽ phải implement các methods này, từ đó *cung cấp tính nhất quán* cho source code của mình.
	- *Code Reusability*: Trong abstract class, ta có thể viết cả abstract methods (không có implement gì) và các methods chung (có implement code) => Chúng ta có thể đặt các common methods vào trong class cha, các class con sẽ được kế thừa và sử dụng bình thường.
	- *Polymorphism*: Mình có thể viết code base trên behavior của abstract class. Code này có thể hoạt động được luôn khi truyền vào 1 mảng các subclass instance => Flexible
	- *Design clarity*: Việc define behavior trong abstract class giúp cho việc đọc code được rõ ràng hơn


## Encapsulation - Đóng gói

![](https://www.scientecheasy.com/wp-content/uploads/2018/06/encapsulation-in-java.png)

### Definition
Đóng gói là quá trình "bọc" đối tượng của ta lại, chỉ "chìa" à các phương thức cần thiết để tương tác với đối tượng đó mà thôi.

Quá trình "đóng gói" này diễn ra thường ngày trong cuộc sống của chúng ta. Ta bấm nút khởi động xe, xe có thể khởi động, nhưng thực tế ta không biết điều gì thực sự xảy ra khi ta bấm nút: Vi mạch thực hiện ra sao, lấy năng lượng như thế nào, tại sao máy lại khởi động được, ....

Việc này tương tự như khi ta đóng gói đối tượng, và chỉ thò ra các public methods mà thôi.

- `public` => Cho phép các thuộc tính được sử dụng thoải mái bởi các lớp khác.
- `protected` => Cho phép các lớp con của lớp cha được phép sử dụng
- `private` => Chỉ cho phép các method thuộc class đó được phép truy cập (các lớp con cũng không được phép).

### Questions

- Tại sao tôi lại cần phải đóng gói?
	- *Data protection*: 
		- Trong quá trình khởi tạo, thao tác, kế thừa, ... data có thể dễ bị thay đổi/modify bởi những action không mong muốn. Bằng việc giới hạn quyền access/ modify data, ta có thể đảm bảo được tính đúng đắn và nhất quán của dữ liệu.
	- Bảo vệ được implementation details:
		- Thứ gì cần thì public ra ngoài, còn lại private implementation thì được giấu bên trong class. Các objects bên ngoài sẽ chỉ biết được public methods, phần còn lại không thể biết, và cũng không cần biết.
	- Dễ maintain
		- Do detail code được đặt bên trong class, và chỉ thò public methods ra ngoài, nên việc  thay đổi detail implementation cũng sẽ không ảnh hưởng tới các object khác.
	- ***Principle of Least Privilege***
		- Biết đủ dùng thôi =)) Cần gì biết lấy =))

- Việc hiểu về đóng gói này giúp gì cho tôi khi lập trình?
	1. Việc xác định rõ data/methods public - private giúp chúng ta bảo vệ được detail implementation, đồng thời code cũng được chặt chẽ hơn.
	2. Dễ viết test: Khi đóng gói logic cùng context vào 1 chỗ sẽ giúp chúng ta dễ viết test hơn, do ngữ cảnh riêng biệt, data cùng loại, function có logic xác định, ...
	3. Hạn chế tối đa việc update data không mong muốn: Ví dụ user password cần được modify by encapsulated logic chứ không được set trực tiếp.

- Sau khi biết về Encapsulation rồi, thì ta có thể làm gì để refactor lại source code?
	- Check lại các class, đặt "đúng chỗ" cho các method public và private. Methods nào mà muốn từ object bên ngoài có thể gọi được thì để public, còn không thì nên để protected/ private.


## Inheritance - Kế thừa

![](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQAq9ofazSiCpBKEG0pweawGgC2Jpq9i3JWEw&s)

### Definition

Kế thừa là khả năng xây dựng class mới dựa trên các class đã tồn tại. Nhờ kế thừa, ta có thể tái sử dụng lại code của class cha (mà không cần sao chép y nguyên code từ class cha vào class con). 
Ngoài ra, ta còn có thể mở rộng thêm class hiện tại, đưa thêm các behaviors mới.

Kế thừa có một rủi ro rất lớn, đó là bạn có thể khiến cho class con hoạt động không giống như class cha. (vi phạm nguyên tắc thay thế Liskov). Điều này dẫn tới bug khó lường trước, và cũng là nguyên nhân dẫn tới 1 nguyên tắc quan trọng nữa khi lập trình OOP: `Composition over Inheritance` - Ưu tiên sử dụng thành phần thay vì kế thừa.

### Drawback

1. Tight Coupling
	- Mỗi khi thay đổi ở base class sẽ ảnh hưởng trực tiếp tới các class con. Hoặc nếu có bug ở code class cha, khả năng các class con cũng bị ảnh hưởng.
	- Nếu base class đã được sử dụng rộng rãi trong source code, việc modify base class sẽ rất khó khăn, vì ảnh hưởng của nó nhiều
2. Limited Flexibility
	- Kế thừa là mối quan hệ "is-a", nên thỉnh thoảng sẽ gặp vài cases đặc biệt, làm cho class con phải kế thừa một số properties/methods mà nó không cần đến =)) Ví dụ: `Bird` có method `fly`. `Penguin` là chim, có thể kế thừa class `Bird`, nhưng nó lại không biết bay => Không cần tới method `fly`, nhưng vẫn phải kế thừa.
3. Kế thừa nhiều lớp
	- Lạm dụng kế thừa khiến cho cây kế thừa bị dài, phức tạp => Khó maintain. Ví dụ: `Object -> Animal -> Mammal -> Primate -> Human`
4. Vi phạm Liskov Substitution Principle
	- TODO


## Polymorphism

![](https://codegym.cc/images/article/1771301a-66f1-469c-868a-41809dc18672/original.png)

### Definition

Đa hình - nhiều hình dạng - là một concept cho phép các classes khác nhau có thể được đối xử như là objects của common superclass. Ví dụ: Tôi không cần biết ông là động vật loại nào, nhưng tôi biết ông có thể `eat()`, hoặc `move()`. 

Khi vào bãi đỗ xe, có rất nhiều loại xe. Bạn có thể không biết loại xe trước mặt là xe gì, nhưng bạn vẫn có thể khởi động được xe và lái đi.
