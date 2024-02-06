# GPU情報取得ツールの使用方法

このツールは、お使いのWindowsシステムにインストールされているNVIDIA GPUのドライバ情報、CUDAバージョン、およびcuDNNバージョンの詳細を収集し、テキストファイルに出力します。出力されるファイルには、GPUのモデル名、ドライババージョン、CUDAおよびcuDNNのバージョンが含まれます。

## 使用方法

以下の手順に従ってください。

1. **PowerShellを管理者権限で開く**  
   スタートメニューを開き、「PowerShell」と入力します。出てきた「Windows PowerShell」を右クリックし、「管理者として実行」を選択します。

2. **スクリプトを実行する**  
   管理者権限で開いたPowerShellウィンドウにて、以下のコマンドをコピー＆ペーストし、実行してください。

   ```
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; Invoke-WebRequest "https://raw.githubusercontent.com/RUTILEA/gpu_info_windows/main/get_gpu_info.ps1" -OutFile "$env:TEMP\get_gpu_info.ps1"; & "$env:TEMP\get_gpu_info.ps1"
   ```

   このコマンドは、GPU情報を収集するスクリプトをダウンロードし、実行します。実行ポリシーはこのプロセスに対してのみ一時的に`Bypass`に設定され、システム全体のポリシーには影響しません。

3. **結果の確認**  
   スクリプトが正常に実行されると、デスクトップ上に`gpu_info.txt`という名前のファイルが作成されます。このファイルを開き、収集されたGPU情報を確認してください。

## 注意事項

- このスクリプトは、信頼できるソース（上記コマンド内のURL）からのみ実行してください。
- 実行ポリシーの変更は、このプロセス限りであり、システム全体のセキュリティポリシーには影響しません。
- スクリプトの実行には管理者権限が必要です。

ご不明な点がある場合は、システム管理者に相談するか、またはスクリプトの提供元（RUTILEA）にサポートを求めてください。
