$HostTest = "8.8.8.8"
$Attempts = 4
$Success = 0

Write-Host "Verificando segurança básica da rede..." -ForegroundColor Cyan

for ($i = 1; $i -le $Attempts; $i++) {
    if (Test-Connection -ComputerName $HostTest -Count 1 -Quiet) {
        Write-Host "Ping $i: OK" -ForegroundColor Green
        $Success++
    } else {
        Write-Host "Ping $i: FALHA" -ForegroundColor Red
    }
    Start-Sleep -Seconds 1
}

$Loss = (($Attempts - $Success) / $Attempts) * 100

Write-Host "`nResultado:"
Write-Host "Perda de pacotes: $Loss%"

if ($Success -eq 0) {
    Write-Host "⚠️ Rede instável ou sem conectividade." -ForegroundColor Yellow
}
elseif ($Loss -gt 50) {
    Write-Host "⚠️ Alta perda de pacotes detectada." -ForegroundColor Yellow
}
else {
    Write-Host "✅ Rede aparentemente estável." -ForegroundColor Green
}
