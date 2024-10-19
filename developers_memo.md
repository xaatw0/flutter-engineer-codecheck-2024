## Githubのレポジトリの作成
flutter-engineer-codecheck-2024 でレポジトリを作成
デフォルトをdevelopブランチで作成
AndroidStudioで上記レポジトリをclone

## マルチプロジェクトのサポート
- melosのインストール
  dart pub global activate melos
  flutter pub add melos --dev
  melos --version

- プロジェクト直下にmelos.yaml を作成
- プロジェクト直下にpackagesディレクトリを作成

## FVMのサポート
- 設定ファイルの作成
  プロジェクト直下に .fvmrcを作成
```
{
    "flutter": "3.24.0"
}
```

- FMVのインストール
  dart pub global activate fvm
  fvm use --force

- IDEの設定
  AndroidStudioの場合、「Setting→Language&Frameworks→Flutter→Flutter SDK path」を「プロジェクト直下/.fvm/flutter_sdk」、「Setting→Language&Frameworks→Dart→Dart SDK path」を「プロジェクト直下/.fvm/flutter_sdk/bin/cache/dart-sdk」に設定する。Enable Dart suppport for the project,Enable Flutter suppport for the projectにチェック

## プロジェクトの作成
- packages ディレクトリ内で以下を実行
```
fvm flutter create -e infrastructure
fvm flutter create -e use_case
fvm flutter create -e domain
fvm flutter create github_browser_app
fvm flutter create -e github_browser_executable
```


## infrastructure層の実装
### ファイルの作成

- packages/infrastructure/test/github_git_repository/github_git_repository_test.json
  テスト用のデータ。`https://api.github.com/search/repositories?q=Flutter&page=2`で取得したデータを半分くらい削除したファイル(ChatGPTで大きくて扱えなかったため、小さくするために削除した)

- packages/infrastructure/lib/github_git_repository/data/github_search_repositories_data.dart
  Githubから読み込んだJSONをDartに変換するクラス

- packages/infrastructure/test/github_git_repository/data/github_search_repositories_data_test.dart
  `github_git_repository_test.json`のJSONのデータを貼り付けた上で、下記のプロンクトを実行。

```
上記のJSONファイルからDartのクラスを作成してください。
全てのJSONの項目を変換してください。
fromJson, toJsonを作成してください

テストコードを、Flutterの通常のテストコードとして独立して作成してください。
項目を全てテストしてください。省略するな
1,2 で別のtestにしてください。
1.通常のコンストラクタからクラスを作成してください。
2.Jsonからクラスを作成してください。作成したクラスをJsonに変換して内容を確認してください。
  jsonの文字列の項目名の後の「:」の後に空白をつけないでください。
出力すべきテストコードのファイル名を出力してください。

JSONが複数ある場合、全てにあるわけではない項目については、Nullbaleのメンバー変数にしてください
一番上のクラス名：GithubSearchRepositoriesData
```

ChatGPT o1-mini を使用：一発でそのまま使用できコードが生成された。
作成されたソースをgithub_search_repositories_data.dartとgithub_search_repositories_data_test.dartにコピー

- packages/infrastructure/lib/github_git_repository/github_git_repository.dart
  Githubからデータを読み込むクラス

- packages/infrastructure/test/github_git_repository/github_git_repository_test.dart
  上記をテストするクラス


- mockitoでテスト
  fvm flutter pub add mockito build_runner --dev
  fvm dart run build_runner build


- ServiceLocatorの作成
  以前はGetItを使用してDIを行っていたが、アンチパターンであると「[なぜ依存を注入するのか　DIの原理・原則とパターン](https://www.amazon.co.jp/%E3%81%AA%E3%81%9C%E4%BE%9D%E5%AD%98%E3%82%92%E6%B3%A8%E5%85%A5%E3%81%99%E3%82%8B%E3%81%AE%E3%81%8B-DI%E3%81%AE%E5%8E%9F%E7%90%86%E3%83%BB%E5%8E%9F%E5%89%87%E3%81%A8%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3-Compass-Books%E3%82%B7%E3%83%AA%E3%83%BC%E3%82%BA-Steven-Deursen-ebook/dp/B0D1FNH7XB/ref=sr_1_2?crid=147KBJJH87PN1&dib=eyJ2IjoiMSJ9.q8TXjj99hhhR5hmLr9tQrcR02YkCJ5TNjwZqealOs1UPYNQZdJao7C_CZWPLMQTG._Ma3jFLMr4ZAY73O6C_DLnFKzq4QTXemrjo4CtMgaG8&dib_tag=se&keywords=%E4%BE%9D%E5%AD%98%E6%80%A7%E6%B3%A8%E5%85%A5&qid=1728867742&sprefix=%E4%BE%9D%E5%AD%98%E6%80%A7%2Caps%2C161&sr=8-2)」に書いてあった(事前に何をDIに設定すれば良いのか分からず、実行時に設定漏れが発覚するため)。ServiceLocatorとして定義するのが良いかと思われる。

## ドメインクラスの作成
- ChatGPTでベースを作成
```
以下のDartのクラスを作って下さい。
クラス名、変数名は適切な英語にしてください。null不許可の変数にはfinalをつけてください。
変数名の頭に、nullable、nonNullable、optional などの接頭語をつけないでください。
全てを含むコンストラクタを作成する
toJsonとfromJsonを作成する
copyWithを作成する。ただし、「変更不可」とある変数はコピーできない
保存するためのファイル名も記載してください。
クラス、コンストラクタ、変数の前にドキュメントコメントを日本語でつけてください。Dartのドキュメントコメントは「///」ではじめます。

クラスのテストコードを作成してください。
テストコードは、Flutterの通常のテストコードとして独立して作成してください。
1,2 で別のtestにしてください。
1.通常のコンストラクタからクラスを作成してください。
2.Jsonからクラスを作成してください。作成したクラスをJsonに変換して内容を確認してください。
  jsonの文字列の項目名の後の「:」の後に空白をつけないでください。
出力すべきテストコードのファイル名を出力してください。
3.copyWithで更新されることを、変数を一つずつ実行して確認してください

クラス名、変数名：英語
ドキュメントコメント：日本語

# クラス名
GitRepositoryEntity

以下の変数があります。全て変更不可
# 文字列型(null不許可)
作者名、レポジトリ名、概要、作者画像

# 数字型(null不許可)
スター数、フォーク数、イシュー数、ウォッチャー数

# 日時型(null不許可)
最終更新日時

```


## アプリの作成
- ChatGPTでベースを作成
```
class SearchRepositoriesModel {
  
  const SearchRepositoriesModel()
  
  final String keyword;
  final bool isLoading;
  final List<GitRepositoryEntity> entities;
  
}

上記のクラスを完成させて。
copyWithを作成して。全ての項目をコピーできる
クラスのテストコードを作成してください。
テストコードは、Flutterの通常のテストコードとして独立して作成してください。
1.通常のコンストラクタからクラスを作成してください。
出力すべきテストコードのファイル名を出力してください。

toJson, fromJsonは不要
```

- UI層にRiverpod の導入
```
cd packages/github_browser_app
fvm flutter pub add flutter_riverpod riverpod_annotation
fvm flutter pub add build_runner riverpod_generator --dev
fvm flutter pub get
```



## UseCaseの作成

```
RepositoryItemをGitRepositoryEntityに変換するメソッドを作成して
```

ドメイン層(アプリで使用したいデータ)とインフラストラクチャ層(Githubから提供されるデータ)の間には乖離があるので、その差分を埋める。インフラストラクチャ層のDataをドメイン層のEntityに変換する


## 画面作成
参考


## 例外の作成
exceptions_when_loading_repositories.dart
- ChatGPTでベースを作成
```
ベースのexceptions_when_loading_repositoriesをsealed クラスとしてDartの例外のクラスを作成してください。
派生として、以下の例外クラスを作成してください。
・ネットワークに繋がっていない状態の時
・アクセスしすぎで、サーバから拒否されたとき

他にも想定される例外があれば追加してください。
```

## Flavor対応
flutter_flavorizrにてFlavorを作成
```
ruby -v
sudo gem update --system
sudo gem install xcodeproj


cd packages/github_browser_executable
fvm flutter pub add flutter_flavorizr --dev
fvm flutter pub get
```


```
app:
  android:
    flavorDimensions: "flavor-type"

flavors:

  dev:
    app:
      name: "GithubBrowser(dev)"
    android:
      applicationId: "com.github.xaatw0.GithubBrowser.dev"
    ios:
      bundleId: "com.github.xaatw0.GithubBrowser.dev"
  prod:
    app:
      name: "GithubBrowser"
    android:
      applicationId: "com.github.xaatw0.GithubBrowser.prod"
    ios:
      bundleId: "com.github.xaatw0.GithubBrowser.prod"
```

github_browser_executableにて、flutter_launcher_icons-dev.yaml、flutter_launcher_icons-prod.yamlを作成
PNGは1024x1024で作成
```
flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icons/icon-dev.png"
  adaptive_icon_background: "#FFFFFF"
  adaptive_icon_foreground: "assets/icons/foreground_icon-dev.png"
```

インストールとアイコン生成(flavor毎に作成される)
fvm flutter pub add flutter_launcher_icons --dev
fvm dart run flutter_launcher_icons


## ARBの作成
- ChatGPTでベースを作成
```
以下をFlutter用のarbファイル用に作成してください
##追加のメッセージ
リセットしますか
読み込んだレポジトリは削除されますが、{keyword String flutter}は維持されます
キャンセルする
リセットする



##フォーマット
arbファイルに追加するため、メッセージごとの行末に「,」は付けてください
最後に「"end":"end"」を付けてください

###app_en.arb用
"英訳の要約のキャメル式":"英訳",
"end":"end"

###app_ja.arb用
"英訳の要約のキャメル式":"日本語のまま",
"end":"end"

###翻訳文内の{}の扱い
placeholdersはapp_en.arbにたいしてのみ、追加します。app_ja.arbには対して作成するな
placeholdersは英語の本文の直後に作成してください

placeholdersの例なので、authenticationCancelledは出力しない
変換元：{name String Apple} 認証がキャンセルされました
変換：
"authenticationCancelled": "{name} Authentication was cancelled",
  "@authenticationCancelled": {
    "placeholders": {
      "name": {
        "type": "String",
        "example": "Apple"
      }
    }
  },
```

## Atomic デザイン
- ディレクトリを作成

``
mkdir lib/widgets/atoms
mkdir lib/widgets/molecules
mkdir lib/widgets/organisms
mkdir lib/widgets/templates
``

## ドキュメントの作成
- ChatGPTでベースを作成
```
・あなたはFlutter開発です。
以下のソースコードを初心者向けに説明のコメントを追加してください。
クラスと引数、メンバー引数、メンバーメソッドにドキュメンテーションコメントを追記してください
最初になにをするソースか説明してください
ソースを書き換えない
「kotlinCopy code」という記載は＊＊絶対に含めるな＊＊
以下のソースコードです。
class PathInfo {
  const PathInfo(
    this.path,
    this.widget,
    this.iconData,
    this.getTitle,
  );

  final String path;
  final Widget widget;
  final IconData iconData;
  final String Function(AppLocalizations appLoc) getTitle;
}
```

## 依存性のmermaidの作成
- ChatGPTでベースを作成
  `melos exec -- type .\pubspec.yaml`をWindowsで実行し、結果を貼り付けて、以下を添付
```
上記はFlutterのマルチプロジェクトのpubspec.yamlの一覧です。依存性を以下の2種類でmarmeid形式で出力して
・自作パッケージの間の依存性のみのグラフ
・各自作パッケージが依存しているパッケージのグラフ(パッケージ毎に一つのグラフを作成)
dependenciesのみ出力する
dependenciesに「flutter」がない場合、flutterは出力しない。 flutter_testはFlutterではない
```
