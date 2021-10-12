## Practice Table View Controller
<img src="https://user-images.githubusercontent.com/22907483/136952807-d1392b97-a746-4031-aee9-a595cf773f40.PNG" width=30%>  <img src="https://user-images.githubusercontent.com/22907483/136952828-6725ea9e-8277-4dbc-8d6e-af44f1e41cde.PNG" width=30%>  
### Static Cells
스토리보드 인스펙터 창을 활용하여 섹션을 추가하고 각 섹션별 row의 갯수도 설정해주었다.  
각 row의 타입도 Basic, Right Detail, Subtitle 등등 다양하게 설정하여 원하는대로 디자인할 수 있었다.  
필요한 경우에는 custom으로 설정 후 원하는 UI컴포넌트를 추가하여 디자인했다.

### Dynamic Prototypes
Section 제목 리스트 그리고 Section별 row의 title들을 아래의 코드와 같이 list에 담았다.
```swift
    let sections: [String] = ["전체 설정", "개인 설정", "기타"]
    let titles: [[String]] = [["공지사항", "실험실", "버전 정보"], ["개인/보안", "알림", "채팅", "멀티프로필"], ["고객센터/도움말"]]
```
그리고 각 Section의 제목은 `sections[section]`, 각 section별 row의 제목은 `titles[indexPath.section][indexPath.row]`로 할당할 수 있었다.
```swift
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = titles[indexPath.section][indexPath.row]
        return cell
    }
```
Section 3개의 row 갯수를 할당하기 위하여 삼항연산자를 중복으로 사용했다.
```swift
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : section == 1 ? 4 : 1
    }
```

Section title의 font를 수정하기 위해 아래의 코드를 활용했다.
```swift
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    }
```
