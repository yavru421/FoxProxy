@echo off
echo FoxProxy - Firefox Command Proxy
powershell -ExecutionPolicy Bypass -File "%~dp0FoxProxy.ps1" %*
