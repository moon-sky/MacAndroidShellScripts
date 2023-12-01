@echo off

echo ---------------删除已有NGC资源---------------
adb root
adb remount
adb shell rm -rf /system/etc/carspeech/assets/ngc/
adb shell rm -rf /sdcard/Android/data/com.xiaopeng.speech.resourcecenter/files/databases/
echo ---------------清理数据完毕---------------

echo ---------------重启语音进程---------------
set "carspeech=com.xiaopeng.carspeechservice"  REM 替换为实际的包名
set "resource=com.xiaopeng.speech.resourcecenter"  REM 替换为实际的包名
REM 获取carspeechservice进程ID
for /f "tokens=1" %%a in ('adb shell "pidof %carspeech%"') do set "pid=%%a"



REM 如果进程ID不为空，则kill进程
if defined pid (
    adb shell "kill %pid%"
    echo 已关闭carspeechservice进程，进程ID为 %pid%
) else (
    echo 未找到carspeechservice进程
)
for /f "tokens=1" %%a in ('adb shell "pidof %resource%"') do set "pid_resource=%%a"

REM 如果进程ID不为空，则kill进程
if defined pid_resource (
    adb shell "kill %pid_resource%"
    echo 已关闭carspeechservice resourcecenter进程，进程ID为 %pid_resource%
) else (
    echo 未找到resourcecenter进程
)

echo ---------------开始下载资源---------------
adb logcat -c

REM 启动 adb logcat 命令并将输出重定向到临时文件
adb logcat > logcat_output.txt

REM 逐行读取日志文件内容
for /f "delims=" %%a in (logcat_output.txt) do (
    REM 检查每一行是否包含 "start" 关键字
    echo %%a | findstr / i "MSG_DOWNLOAD_ALL_RESOURCE DONE" > nul
    if not errorlevel 1 (
	    set "file_path=/sdcard/Android/data/com.xiaopeng.speech.resourcecenter/files/databases/"
        REM 如果找到 "start" 关键字，则退出脚本
        echo "start" 关键字已找到，退出脚本。
		        REM 使用adb pull命令拉取文件
        adb pull %file_path% .

        REM 检查adb pull命令的退出状态
        echo 文件成功拉取到当前目录。
        goto :eof
    )
)
REM 清理临时文件
del logcat_output.txt
