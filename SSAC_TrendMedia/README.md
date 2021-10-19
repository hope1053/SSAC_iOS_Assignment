## Trend Media (Developed)
### KingFisher(Image Library) & Passing data between viewControllers
`Scene A` 컨트롤러에서 table view cell을 클릭했을 때 `Scene C`컨트롤러로 데이터를 전달해주는 기능
1. 먼저 데이터를 받을 SceneCviewController에 데이터를 받을 변수를 정의해주었다.
```swift
var currentTvShow: TvShow?
```
2. 그 중 자주 사용하게 될 데이터를 할당할 변수들을 몇 개 더 정의해주었다.
```swift
var starring: String = "" // 출연자 문자열
var starringList: [String] = [] // 현재 문자열로 전체가 묶여있기 때문에 이를 분리하여 문자열 배열로 넣어줄 변수
var tvShowName: String? // 티비쇼 이름
```
3. viewDidLoad() 메서드 내에 `currentTvShow`에 데이터를 할당받은 다음 처리할 내용을 작성하였다.
```swift
starring = currentTvShow!.starring
tvShowName = currentTvShow?.title
starringList = starring.components(separatedBy: ", ") // 받아온 출연자 문자열을 쉼표 + 빈칸 을 기준으로 잘라서 list로 변환하는 코드
```
4. 받아온 데이터를 활용해 UI를 업데이트하는 함수를 따로 구현했다. 이때 headerImageView의 이미지는 `KingFisher`라이브러리를 활용하여 url에서 이미지를 다운받아 적용시켰다.
```swift
func updateUI() {
        headerPosterImageView.image = UIImage(named: tvShowName!)
        headerTitleLabel.text = tvShowName!
        let url = URL(string: currentTvShow!.backdropImage)
        headerImageView.kf.setImage(with: url)
    }
```
5. ScneneAViewController에서 데이터를 전달해준다. 이때 `TvShow` struct 타입의 인스턴스를 전달해준다.
```swift
 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "SceneC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SceneCTableViewController") as! SceneCTableViewController
        vc.currentTvShow = tvShowInformation.tvShow[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
```
