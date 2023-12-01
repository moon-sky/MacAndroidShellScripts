@echo off

set "log_file=logcat_output.txt"

REM 逐行读取日志文件内容
for /f "usebackq delims=" %%a in ("%log_file%") do (
    REM 检查每一行是否包含 "start" 关键字
    echo %%a | findstr /i "MSG_DOWNLOAD_ALL_RESOURCE" > nul
    if not errorlevel 1 (
        REM 如果找到 "start" 关键字，则退出脚本
        echo "MSG_DOWNLOAD_ALL_RESOURCE" 关键字已找到，停止循环。
        goto :eof
    )
)

REM 如果循环执行到这里，表示未发现 "start" 关键字
echo 未找到 "MSG_DOWNLOAD_ALL_RESOURCE" 关键字。

pause