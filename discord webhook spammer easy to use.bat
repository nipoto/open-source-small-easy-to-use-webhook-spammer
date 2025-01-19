@echo off
setlocal enabledelayedexpansion

:main
cls
set "webhook="
set "message="
set "count="

if exist webhook.txt (
    set /p "use_last_webhook=Do you want to use the last webhook? (y/n): "
    if /i "!use_last_webhook!"=="y" (
        set /p "webhook="<webhook.txt
    )
)

if not defined webhook (
    set /p "webhook=please add your webhook (made by adolf_nipoto on discord) "
    echo !webhook!>webhook.txt
)

set /p "message=What message do you wanna send? "
set /p "count=How many times to send that message? (min 1) (max 1000) "

for /l %%i in (1,1,!count!) do (
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"!message!\"}" !webhook!
    echo Sent %%i
)

set /p "repeat=Do you want to do it again? (y/n): "
if /i "!repeat!"=="y" (
    goto main
)

endlocal
exit
