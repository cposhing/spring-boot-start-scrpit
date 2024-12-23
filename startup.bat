@echo off

SET APP_NAME=your_jar_name
title %APP_NAME%

@rem ENV Setting
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto execute

echo [错误]: JAVA_HOME 未定义，或者运行路径中未包含java.exe程序
goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%\bin\java.exe

if exist "%JAVA_EXE%" goto execute
echo [错误]: JAVA_HOME 定义在一个错误的路径中： %JAVA_HOME%
goto fail

@rem ENV setting is ok
:execute
@rem get current script path
set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_HOME=%DIRNAME%
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

::运行参数设置::
@rem 指定日志配置(以logback.xml为例)位置(可选参数)
set LOG_CONFIG=-Dlogging.config=%APP_HOME%config\logback.xml

@rem 指定application.properties位置(可选参数)
set PROP_CONFIG=-Dspring.config.location=%APP_HOME%config\application.properties

@rem 指定是否开启ansi彩色日志
set ANSI_CONFIG=-Dspring.output.ansi.enabled=always

@rem 指定服务名称和时区(可选参数)
set JAVA_OPTS_COMMON="-Dname=%APP_NAME%" "-Duser.timezone=Asia/Shanghai"

@rem 指定JVM参数(可选参数)
set JAVA_OPTS="-Xms4096m -Xms4096m -XX:NewSize=2048m -XX:MaxNewSize=2048m"

@rem 指定pid文件位置(可选参数) 
set PID_FILE=-Dspring.pid.file=%APP_HOME%application.pid

@rem d file Encoding
set D_FILE_ENCODING="-Dfile.encoding=UTF-8"

@rem 指定jar名称
set EXEC_JAR=%APP_HOME%%APP_NAME%.jar

"%JAVA_EXE%" %D_FILE_ENCODING%^
  "%LOG_CONFIG%" "%PROP_CONFIG%" -jar "%EXEC_JAR%"

:fail
pause

