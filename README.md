# Googleカレンダー, Trelloの自動整列スクリプト
`calendar_trello_launcher.bat`

このバッチスクリプトはBraveで上2/3にGoogle カレンダー、下1/3にTrelloを自動で配置するツールです。

## 使い方
- urls.txt.exampleをコピーしてurls.txtにリネームし、URLを開きたいページに書き換える
- Windows環境で.batをダブルクリックで実行<br>
※urls.txtが存在しない、またはURLが不正な場合は自動的に以下の既定URLが使用されます。<br>
Googleカレンダー → https://calendar.google.com<br>
Trello → https://trello.com

## 注意事項
- このスクリプトは実行時にすべてのBraveウィンドウを終了します。
- 必要に応じてパスを変更して利用してください。

## Braveシールドについて
GoogleカレンダーやTrelloはログイン情報をクロスサイトCookieに保存するため、Shieldsが有効なままだとログイン状態が保持されない場合があります。

### 対処法
1. 右上の🦁シールドアイコンをクリック
2. 「このサイトのシールドをオフ」に設定