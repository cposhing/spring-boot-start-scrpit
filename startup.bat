@echo off

SET APP_NAME=your_jar_name
title %APP_NAME%

@rem ENV Setting
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto execute

echo [����]: JAVA_HOME δ���壬��������·����δ����java.exe����
goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%\bin\java.exe

if exist "%JAVA_EXE%" goto execute
echo [����]: JAVA_HOME ������һ�������·���У� %JAVA_HOME%
goto fail

@rem ENV setting is ok
:execute
@rem get current script path
set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_HOME=%DIRNAME%
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

::���в�������::
@rem ָ����־����(��logback.xmlΪ��)λ��(��ѡ����)
set LOG_CONFIG=-Dlogging.config=%APP_HOME%config\logback.xml

@rem ָ��application.propertiesλ��(��ѡ����)
set PROP_CONFIG=-Dspring.config.location=%APP_HOME%config\application.properties


@rem ָ���������ƺ�ʱ��(��ѡ����)
set JAVA_OPTS_COMMON="-Dname=%APP_NAME%" "-Duser.timezone=Asia/Shanghai"

@rem ָ��JVM����(��ѡ����)
set JAVA_OPTS="-Xms4096m -Xms4096m -XX:NewSize=2048m -XX:MaxNewSize=2048m"

@rem ָ��pid�ļ�λ��(��ѡ����) 
set PID_FILE=-Dspring.pid.file=%APP_HOME%application.pid

@rem d file Encoding
set D_FILE_ENCODING="-Dfile.encoding=UTF-8"

@rem ָ��jar����
set EXEC_JAR=%APP_HOME%%APP_NAME%.jar

"%JAVA_EXE%" %D_FILE_ENCODING%^
  "%LOG_CONFIG%" "%PROP_CONFIG%" -jar "%EXEC_JAR%"

:fail
pause

