@echo off
:: Verifica se o script está rodando como Administrador
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [OK] Rodando como Administrador.
) else (
    echo [ERRO] Por favor, execute este arquivo clicando com o botao direito e selecionando "Executar como Administrador".
    pause
    exit
)

title Script de Otimizacao Patrick - Engenharia
color 0b

echo ======================================================
echo    INICIANDO LIMPEZA DE ARQUIVOS TEMPORARIOS
echo ======================================================
del /q /f /s %TEMP%\*
del /q /f /s C:\Windows\Temp\*
del /q /f /s C:\Windows\Prefetch\*
cleanmgr /sagerun:1
echo [OK] Limpeza concluida!

echo.
echo ======================================================
echo    LIMPANDO CACHE DE SOMBREAMENTO (SHADERS)
echo ======================================================
:: Limpa cache de Shaders para NVIDIA, AMD e DirectX (Geral)
echo Removendo arquivos de cache de GPU antigos...
del /q /f /s "%LocalAppData%\D3DSCache\*" >nul 2>&1
del /q /f /s "%LocalAppData%\NVIDIA\DXCache\*" >nul 2>&1
del /q /f /s "%LocalAppData%\AMD\DxCache\*" >nul 2>&1
echo [OK] Cache de sombreamento limpo!

echo.
echo ======================================================
echo    LIMPEZA DO HISTORICO DO WINDOWS DEFENDER
echo ======================================================
:: Remove o historico de verificacoes e acoes do Defender
del /q /s "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service\*" >nul 2>&1
echo [OK] Historico de protecao limpo!

echo.
echo ======================================================
echo    OTIMIZACAO DE REDE E SISTEMA
echo ======================================================
ipconfig /flushdns
sfc /scannow
echo [OK] Rede e Sistema verificados!

echo.
echo ======================================================
echo    SEGURANCA: FERRAMENTA DE REMOCAO DE MALWARE (MRT)
echo ======================================================
echo Iniciando verificacao rapida em segundo plano...
start /wait mrt.exe /n /q
echo [OK] Verificacao de Malware concluida!

echo.
echo ======================================================
echo    DESATIVANDO TELEMETRIA E COLETA DE DADOS
echo ======================================================
sc stop DiagTrack
sc config DiagTrack start= disabled
sc stop dmwappushservice
sc config dmwappushservice start= disabled
echo [OK] Telemetria desativada!

echo.
echo ======================================================
echo    GARANTINDO QUE O RECALL ESTEJA DESATIVADO
echo ======================================================
DISM /Online /Disable-Feature /FeatureName:"Recall"
echo [OK] Comando Recall processado!

echo.
echo ======================================================
echo    PROCESSO FINALIZADO COM SUCESSO!
echo ======================================================
echo Recomendado reiniciar o computador para aplicar tudo.
pause