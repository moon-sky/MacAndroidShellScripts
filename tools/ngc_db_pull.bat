@echo off

REM 步骤1: 使用adb pull指定文件到当前目录
echo ---------------拉取资源到本地---------------
adb pull /sdcard/Android/data/com.xiaopeng.speech.resourcecenter/files/databases/test/ .

REM 步骤2: 切换到指定路径的仓库，并提交更改，替换成自己仓库的路径
echo ---------------拷贝资源到仓库---------------
copy /Y test\resource_coordinates_info.json "C:\Users\wanghx2\Develop\au8295_xp\h93\carspeech\assets\ngc\"
copy /Y test\resource.db "C:\Users\wanghx2\Develop\au8295_xp\h93\carspeech\assets\ngc\"
cd /d C:\Users\wanghx2\Develop\au8295_xp\

echo ---------------提交资源到指定分支---------------
git add .
git commit -m "[ Modify      ] 更新ngc资源
[ Project     ] H93/F30
[ Module      ] ngc
[ Description ] 见需求描述
[ Reference   ] http://zendao.xiaopeng.local//zentao/bug-view-249216.html
[ Company     ] 北京小鹏
[ Team        ] 智能语音大屏开发组"
git pull

REM 步骤3: 使用git review
REM 获取当前仓库分支名称
for /f "delims=" %%i in ('git symbolic-ref --short HEAD') do set "current_branch=%%i"
git review %current_branch%