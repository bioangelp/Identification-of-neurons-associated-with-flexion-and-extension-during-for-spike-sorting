$ultimo = Get-ChildItem -Path "data_" -File | Sort-Object CreationTime -Descending | Select-Object -First 1
if ($ultimo) { Remove-Item $ultimo.FullName -Force }
Remove-Item -Path "raw\*" -Recurse -Force