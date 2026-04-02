@echo off
title POS Java 一键启动脚本
echo ==========================================
echo       正在启动 POS Java 系统...
echo ==========================================

echo.
echo [1/2] 正在编译和安装公共模块依赖 (mvn clean install -DskipTests) ...
call mvn clean install -DskipTests
if %ERRORLEVEL% neq 0 (
    echo.
    echo [错误] 项目构建失败，请检查上面的报错信息！
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo [2/2] 正在启动 Web 服务层 (mvn spring-boot:run -pl pos-web) ...
call mvn spring-boot:run -pl pos-web -Dspring-boot.run.jvmArguments="-Dspring.output.ansi.enabled=ALWAYS"

pause
