@echo off
echo ============================================
echo   Smart R2-D2 Installer for Android 10+
echo ============================================
echo.

:: Check ADB is available
adb version >nul 2>&1
if errorlevel 1 (
    echo ERROR: ADB not found. Make sure platform-tools is in your PATH.
    pause
    exit /b 1
)

:: Check device is connected
echo Looking for Android device...
adb wait-for-device
echo Device found.
echo.

:: Uninstall previous version if exists
echo Uninstalling previous version (if any)...
adb shell pm uninstall --user 0 com.hasbro.HeroDroid >nul 2>&1

:: Install APK (looks for the APK in the same folder as this .bat)
set APK=%~dp0R2D2_v7.apk
if not exist "%APK%" (
    echo ERROR: APK not found at %APK%
    echo Place the signed APK in the same folder as this script
    echo and rename it to: R2D2_v7.apk
    pause
    exit /b 1
)

echo Installing APK...
adb install "%APK%"
if errorlevel 1 (
    echo ERROR: Installation failed.
    pause
    exit /b 1
)
echo.

:: Grant Bluetooth/Location permissions
echo Granting location permissions for Bluetooth...
adb shell pm grant com.hasbro.HeroDroid android.permission.ACCESS_FINE_LOCATION
adb shell pm grant com.hasbro.HeroDroid android.permission.ACCESS_COARSE_LOCATION
echo.

echo ============================================
echo   Installation completed successfully!
echo   R2-D2 should now be detected via Bluetooth.
echo ============================================
echo.
pause