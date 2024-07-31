$excludeDirs = @("node_modules", ".git")
$rootDir = Get-Location

function Show-Tree {
    param (
        [string]$path,
        [string]$indent = ""
    )
    
    $items = Get-ChildItem $path -Force | Where-Object { 
        ($_.Name -notin $excludeDirs) -and ($_.Attributes -notmatch "Hidden") 
    }
    
    foreach ($item in $items) {
        if ($item.PSIsContainer) {
            Write-Output "$indent|-- $($item.Name)\"
            Show-Tree -path $item.FullName -indent "$indent|   "
        } else {
            Write-Output "$indent|-- $($item.Name)"
        }
    }
}

Write-Output $rootDir
Show-Tree -path $rootDir
