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
