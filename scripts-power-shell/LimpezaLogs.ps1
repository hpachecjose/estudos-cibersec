# Defina o diretório onde estão os logs
$LogPath = "C:\Logs"

# Defina o número de dias para manter os arquivos
$DaysToKeep = 7

# Calcula a data limite
$LimitDate = (Get-Date).AddDays(-$DaysToKeep)

# Lista os arquivos de log mais antigos que a data limite
$OldLogs = Get-ChildItem -Path $LogPath -Filter *.log -File | Where-Object { $_.LastWriteTime -lt $LimitDate }

# Remove os arquivos antigos
foreach ($Log in $OldLogs) {
    try {
        Remove-Item $Log.FullName -Force
        Write-Output "Arquivo removido: $($Log.FullName)"
    } catch {
        Write-Output "Erro ao remover: $($Log.FullName) - $_"
    }
}
