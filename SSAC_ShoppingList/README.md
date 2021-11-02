# Shopping List
## ✔️ 21.11.02 업데이트
### 🔘 Realm을 이용한 데이터 저장
기존에 UserDefaults를 이용하여 데이터를 저장했던 부분을 Realm을 사용하여 저장하는 코드로 수정했다.
- 다음과 같이 `ShoppingList`라는 이름의 테이블을 작성했다. 
```swift
import RealmSwift

class ShoppingList: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var content: String // 내용(필수)
    @Persisted var isDone: Bool // 구매했는지 확인기능(필수)
    @Persisted var favorite: Bool // 즐겨찾기 기능(필수)

    convenience init(content:String) {
        self.init()
        
        self.content = content
        self.isDone = false
        self.favorite = false
    }
}
```
- 저장되는 Realm 파일의 주소를 가져오는 localRealmr과 ShoppingList 형식의 데이터를  배열로 갖고 있는 tasks를 선언했다.
```swift
let localRealm = try! Realm()
var tasks: Results<ShoppingList>!
```
- 현재는 mainView외에 다른 뷰는 존재하지 않기 때문에 viewDidLoad 메서드 내에서 데이터를 불러오는 코드를 작성했다.
```swift
override func viewDidLoad() {
        super.viewDidLoad()
        tasks = localRealm.objects(ShoppingList.self)
    }
```
- tableView과 관련된 코드도 tasks 배열을 반영하는 코드로 수정했다.
```swift
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath) as? shoppingCell else {
            return UITableViewCell()
        }
        
        let currentProduct = tasks[indexPath.row]
        
        cell.nameLabel.text = currentProduct.content
        cell.starButton.isSelected = currentProduct.favorite
        cell.checkButton.isSelected = currentProduct.isDone
        
        cell.background.layer.masksToBounds = true
        cell.background.layer.cornerRadius = 10
        
        return cell
    }
```
- textField에 물품 이름을 작성 후 추가 버튼을 탭하는 경우, 해당 데이터를 저장 후 업데이트하는 코드로 수정했다.
```swift
@IBAction func addList(_ sender: UIButton) {
        guard let newProduct = inputTextField.text else {return}
        if newProduct == "" {
            let alert = UIAlertController(title: "목록을 입력해주세요!", message: nil, preferredStyle: .alert)
            let OK = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(OK)
            present(alert, animated: true, completion: nil)
        } else {
            // textField가 비어있지 않은 경우 text를 content로 가지는 ShoppingList 객체를 생성 후 데이터베이스에 추가해준다.
            let task = ShoppingList(content: newProduct)
            try! localRealm.write {
                localRealm.add(task)
            }
            // 저장한 데이터를 다시 한 번 불러오고
            tasks = localRealm.objects(ShoppingList.self)
            // 이를 바탕으로 tableView를 다시 한 번 reload 해준다.
            shoppingTable.reloadData()
            print("Realm is located at:", localRealm.configuration.fileURL!)
        }

        inputTextField.text = ""
    }
```