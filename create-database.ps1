# Get the SQL script path
$sqlFile = "d:\java-back-end\database-schema.sql"

# Check if file exists
if (-Not (Test-Path $sqlFile)) {
    Write-Host "Error: SQL file not found at $sqlFile" -ForegroundColor Red
    exit 1
}

# Path to MySQL - find it in common locations
$mysqlFound = $false
$mysqlPath = ""

$commonPaths = @(
    "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe",
    "C:\Program Files\MySQL\MySQL Server 8.1\bin\mysql.exe",
    "C:\Program Files\MySQL\MySQL Server 5.7\bin\mysql.exe",
    "C:\Program Files (x86)\MySQL\MySQL Server 8.0\bin\mysql.exe",
    "C:\xampp\mysql\bin\mysql.exe",
    "C:\wamp\bin\mysql\mysql8.0.1\bin\mysql.exe",
    "C:\mysql\bin\mysql.exe",
    "C:\MySQLServer\bin\mysql.exe"
)

foreach ($path in $commonPaths) {
    if (Test-Path $path) {
        $mysqlPath = $path
        $mysqlFound = $true
        Write-Host "Found MySQL at: $mysqlPath" -ForegroundColor Green
        break
    }
}

if (-not $mysqlFound) {
    Write-Host "MySQL not found in common paths" -ForegroundColor Red
    Write-Host "Attempting to find MySQL..." -ForegroundColor Yellow
    $mysqlPath = Get-Command mysql -ErrorAction SilentlyContinue
    if ($mysqlPath) {
        $mysqlPath = $mysqlPath.Source
    } else {
        Write-Host "Please ensure MySQL is installed and in your PATH" -ForegroundColor Red
        exit 1
    }
}

Write-Host "Creating database and tables..." -ForegroundColor Cyan

# Run the SQL script using cmd
$cmd = "cmd /c type `"$sqlFile`" | `"$mysqlPath`" -u root -proot"
Invoke-Expression $cmd

Write-Host "" -ForegroundColor Green
Write-Host "Database setup complete!" -ForegroundColor Green
