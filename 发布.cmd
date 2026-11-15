@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo ==========================================================
echo   dsh-demian-drama-strip  一键发布（npm + GitHub）
echo ==========================================================
echo.

where npm >nul 2>nul
if errorlevel 1 goto NONPM
where git >nul 2>nul
if errorlevel 1 goto NOGIT

echo [1/5] 检查要发的文件
call npm pack --dry-run
echo.
pause
echo.

echo [2/5] 登录 npm（浏览器会打开，登录完回到这个窗口）
call npm login
echo.

echo [3/5] 发布到 npm
call npm publish --access public
if errorlevel 1 goto FAIL

echo.
echo [4/5] 推到 GitHub
set "GHUSER="
set /p GHUSER=你的 GitHub 用户名: 
set "REPO=dsh-demian-drama-strip"
set "REPOIN="
set /p REPOIN=仓库名（直接回车用 dsh-demian-drama-strip）: 
if not "%REPOIN%"=="" set "REPO=%REPOIN%"

git config user.email >nul 2>nul
if errorlevel 1 (
  set "GITMAIL="
  set /p GITMAIL=git 提交邮箱: 
  git config --global user.email "!GITMAIL!"
)
git config user.name >nul 2>nul
if errorlevel 1 (
  set "GITNAME="
  set /p GITNAME=git 提交名: 
  git config --global user.name "!GITNAME!"
)

if not exist ".git" git init
git add -A
git commit -m "dsh-demian-drama-strip 0.1.0: drama strip skill bundle"
git branch -M main
git remote remove origin >nul 2>nul
git remote add origin https://github.com/%GHUSER%/%REPO%.git
git push -u origin main
if errorlevel 1 goto PUSHFAIL

echo.
echo [5/5] 把 entry.json 里的占位符换成你的用户名
powershell -NoProfile -Command "(Get-Content -Raw 'market\entry.json') -replace 'REPLACE_WITH_YOUR_GITHUB_USER','%GHUSER%' | Set-Content -NoNewline -Encoding utf8 'market\entry.json'"

echo.
echo ==========================================================
echo  完成
echo    npm : https://www.npmjs.com/package/dsh-demian-drama-strip
echo    repo: https://github.com/%GHUSER%/%REPO%
echo.
echo  下一步：按 market\PR.md 把那一行加进 awesome-dsh-plugin 的 README 并提 PR
echo ==========================================================
pause
exit /b 0

:NONPM
echo [x] 没找到 npm。
echo     先装 Node.js LTS: https://nodejs.org/zh-cn   装完关掉本窗口重开。
pause
exit /b 1

:NOGIT
echo [x] 没找到 git。
echo     先装 Git: https://git-scm.com/download/win   装完关掉本窗口重开。
pause
exit /b 1

:PUSHFAIL
echo.
echo [x] 推送失败。多半是 GitHub 上还没有这个空仓库：
echo     先去 https://github.com/new 建 %REPO%（不要勾 README），再重跑一次本脚本。
pause
exit /b 1

:FAIL
echo.
echo [x] 上一步失败了，看上面的报错。
pause
exit /b 1
