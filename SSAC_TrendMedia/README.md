# Trend Media
## ✔️ 21.10.18 업데이트
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
## ✔️ 21.10.27 업데이트
🔘 PageNation 구현
- TMDB의 URL에는 따로 page나 보여줄 콘텐츠의 갯수가 언급돼있지 않아서 `page='숫자'` 쿼리를 추가해봤는데 적용이 되는걸 확인할 수 있었다! 
- startPage라는 변수를 생성 후 1을 할당해주었다.(1페이지부터 정보를 받아올 것이기 때문에!)
- viewDidLoad 메서드 내에서 prefetchDatasource도 연결시켜주었다.
```swift
var startPage = 1

override func viewDidLoad() {
  tableView.prefetchDataSource = self
}
```

- extension으로 해당 뷰컨트롤러에서 프로토콜을 채택해주고 prefetchRowsAt 메서드를 사용했다.
- 만약 현재 가지고 있는 데이터를 다 보여준 상태 + 더 보여주고싶은 데이터가 남아있는 경우, page를 하나 더 올려주고 다시 fetchTrendingData를 실행하여 다음 페이지 데이터를 받아오도록 설정했다.
- 이 과정에서 초반에 20개 데이터로 한정시켜놓기위해 작성한 코드를 지우는걸 깜빡해서 아무리해도 데이터가 더 로딩되지 않는 오류를 겪어서 고생했다💦 내가 써놓은 코드를...ㅎㅎ..... 내가 까먹어서 .... 다음부턴 잘 구현한 것 같은데 제대로 작동하지 않으면 내가 쓴 코드를 자세히 들여다봐야겠다 ,,
```swift
extension SceneATableViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if trendingData.count - 1 == indexPath.row && startPage <= 10 {
                startPage += 1
                fetchTrendingData()
            }
        }
    }
}
```
🔘 TMDB API 연결
- 기존에 주어진 swift 파일 안에 있는 데이터를 테이블뷰에 띄우도록 구현했던 부분을 TMDB API를 이용하여 현재 Trending List에 있는 데이터를 받아와 반영하도록 코드를 수정했다.
