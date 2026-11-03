<#
.SYNOPSIS
    Creates a branch and git worktree for a new agent task.

.PARAMETER TaskName
    Short task identifier, e.g. "fix-login-bug". Used to name the branch
    (agent/<TaskName>) and the worktree folder (ai-foundation-<TaskName>).

.EXAMPLE
    .\scripts\new-agent.ps1 -TaskName "hello-test"
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$TaskName
)

$ErrorActionPreference = "Stop"

$repoRoot = (git rev-parse --show-toplevel 2>$null)
if (-not $repoRoot) {
    Write-Error "This script must be run from inside the ai-foundation git repository."
    exit 1
}
$repoRoot = $repoRoot -replace "/", "\"

$branchName = "agent/$TaskName"
$worktreeRoot = "C:\dev\worktrees"
$worktreePath = Join-Path $worktreeRoot "ai-foundation-$TaskName"

if (Test-Path $worktreePath) {
    Write-Error "Worktree path already exists: $worktreePath"
    exit 1
}

if (-not (Test-Path $worktreeRoot)) {
    New-Item -ItemType Directory -Path $worktreeRoot -Force | Out-Null
}

Push-Location $repoRoot
try {
    git fetch origin
    git worktree add -b $branchName $worktreePath origin/main
}
finally {
    Pop-Location
}

Write-Host ""
Write-Host "Worktree ready for task '$TaskName'." -ForegroundColor Green
Write-Host "  Branch:   $branchName"
Write-Host "  Worktree: $worktreePath"
Write-Host ""
Write-Host "To start working:"
Write-Host "  cd `"$worktreePath`""
Write-Host "  claude"
Write-Host ""
Write-Host "When done: push the branch and open a PR with 'gh pr create'. Do not merge to main yourself."
