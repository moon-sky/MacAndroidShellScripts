@echo off

set "log_file=logcat_output.txt"

REM ���ж�ȡ��־�ļ�����
for /f "usebackq delims=" %%a in ("%log_file%") do (
    REM ���ÿһ���Ƿ���� "start" �ؼ���
    echo %%a | findstr /i "MSG_DOWNLOAD_ALL_RESOURCE" > nul
    if not errorlevel 1 (
        REM ����ҵ� "start" �ؼ��֣����˳��ű�
        echo "MSG_DOWNLOAD_ALL_RESOURCE" �ؼ������ҵ���ֹͣѭ����
        goto :eof
    )
)

REM ���ѭ��ִ�е������ʾδ���� "start" �ؼ���
echo δ�ҵ� "MSG_DOWNLOAD_ALL_RESOURCE" �ؼ��֡�

pause