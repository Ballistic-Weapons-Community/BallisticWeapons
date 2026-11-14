<#
.SYNOPSIS
    Compiles the Ballistic Weapons packages of a checkout with UCC and reports errors and new warnings.

.DESCRIPTION
    The compile happens in a build folder of its own (-WorkDir). The game folder is only read from:
    its System folder is copied there once (without the BW packages, so they get rebuilt) and the
    asset folders (Textures, Sounds, StaticMeshes, Animations, Music) are linked as junctions.

    With -Compare, the same packages are first compiled from that git ref (for a pull request: the
    branch it goes into) and only warnings the checkout adds are reported as new.

    Exit code: 0 when the checkout compiles, 1 when it has errors, 2 when the check itself could not run.

.EXAMPLE
    .\Tools\CompileCheck.ps1 -GameDir C:\UT2004
    .\Tools\CompileCheck.ps1 -GameDir C:\UT2004 -Compare upstream/dev
#>
param(
    # A UT2004 folder with Ballistic Weapons installed (it needs the BW texture, sound and mesh packages).
    [Parameter(Mandatory = $true)][string]$GameDir,
    # The checkout to compile. Default: the repository this script is in.
    [string]$Source = '',
    # Git ref to compare warnings with, e.g. upstream/dev. Empty: report every warning.
    [string]$Compare = '',
    # The build folder (about 650 MB, kept between runs). Default: $env:BW_COMPILE_WORKDIR, else %LOCALAPPDATA%\BWCompileCheck.
    [string]$WorkDir = $(if ($env:BW_COMPILE_WORKDIR) { $env:BW_COMPILE_WORKDIR } else { Join-Path $env:LOCALAPPDATA 'BWCompileCheck' }),
    # Seconds one UCC run may take before it is stopped.
    [int]$TimeoutSeconds = 600
)

$ErrorActionPreference = 'Stop'

# Compile order. A package folder of the checkout that is not listed here is compiled last, with a note.
$KnownPackages = @(
    'BCoreProV55', 'BallisticProV55', 'BWBP_SKC_Pro', 'BWBP_OP_Pro', 'BWBP_JCF_Pro', 'BWBP_SWC_Pro',
    'BWBPAirstrikesPro', 'BWBP_APC_Pro', 'BWBP_VPC_Pro', 'BWInteractions3', 'GunGameBW'
)
# Packages from outside this repository that a BW package needs compiled before it (their .u comes from the game folder).
$Dependencies = @{ 'BWInteractions3' = @('unrealextension') }
# Folders that hold code but are not part of the release build.
$SkipFolders = @('Legacy code', 'Ballistic Weapons Singleplayer mode', 'BWBP_JWC_Pro')
# Asset folders the source loads with #exec OBJ LOAD FILE=..\<folder>\...
$AssetFolders = @('Textures', 'Sounds', 'StaticMeshes', 'Animations', 'Music')
# Warnings that come from the asset packages, not from the code.
$NoisePatterns = @('invalid parent bone index')

$InActions = [bool]$env:GITHUB_ACTIONS

function Stop-Setup([string]$Message) {
    if ($InActions) { Write-Output "::error::$Message" } else { Write-Host "ERROR: $Message" -ForegroundColor Red }
    exit 2
}

function Get-Packages([string]$Root) {
    $found = @(Get-ChildItem -LiteralPath $Root -Directory |
        Where-Object { ($SkipFolders -notcontains $_.Name) -and (Test-Path -LiteralPath (Join-Path $_.FullName 'Classes')) } |
        ForEach-Object { $_.Name })
    $ordered = @($KnownPackages | Where-Object { $found -contains $_ })
    $extra = @($found | Where-Object { $KnownPackages -notcontains $_ } | Sort-Object)
    foreach ($p in $extra) { Write-Host "Note: $p is not in the compile order list of CompileCheck.ps1; compiling it last." }
    return @($ordered + $extra)
}

# ---------------------------------------------------------------- build folder

function Initialize-WorkDir([string[]]$Packages) {
    $gameSystem = Join-Path $GameDir 'System'
    if (-not (Test-Path -LiteralPath (Join-Path $gameSystem 'UCC.exe'))) { Stop-Setup "No System\UCC.exe in GameDir '$GameDir'." }
    $sys = Join-Path $WorkDir 'System'
    New-Item -ItemType Directory -Force -Path $sys | Out-Null

    # Everything UCC needs from System, except the BW packages themselves (they would be loaded instead of compiled).
    # robocopy only copies what is new or changed, so later runs take a second or two.
    $exclude = @()
    foreach ($p in ($KnownPackages + $Packages | Select-Object -Unique)) { $exclude += "$p.u"; $exclude += "$p.ucl" }
    $null = & robocopy $gameSystem $sys *.u *.dll *.exe *.int *.ini /XF @exclude /R:1 /W:1 /NFL /NDL /NJH /NJS /NP
    if ($LASTEXITCODE -ge 8) { Stop-Setup "Copying '$gameSystem' to '$sys' failed (robocopy exit code $LASTEXITCODE)." }

    foreach ($a in $AssetFolders) {
        $link = Join-Path $WorkDir $a
        $target = Join-Path $GameDir $a
        if (-not (Test-Path -LiteralPath $target)) { continue }
        if (-not (Test-Path -LiteralPath $link)) {
            New-Item -ItemType Junction -Path $link -Value $target | Out-Null
        }
    }
}

function Write-BuildIni([string[]]$Packages) {
    $sys = Join-Path $WorkDir 'System'
    $gameIni = Join-Path (Join-Path $GameDir 'System') 'UT2004.ini'
    if (-not (Test-Path -LiteralPath $gameIni)) { Stop-Setup "No System\UT2004.ini in GameDir '$GameDir'." }
    $lines = Get-Content -LiteralPath $gameIni

    # The game's own EditPackages up to the first BW package (the stock packages and whatever comes before BW).
    $stock = @()
    $section = ''
    foreach ($l in $lines) {
        if ($l -match '^\s*\[(.+)\]\s*$') { $section = $Matches[1]; continue }
        if ($section -eq 'Editor.EditorEngine' -and $l -match '^\s*EditPackages\s*=\s*(\S+)') {
            $name = $Matches[1]
            if ($KnownPackages -contains $name -or $Packages -contains $name) { break }
            if (Test-Path -LiteralPath (Join-Path $sys "$name.u")) { $stock += $name }
        }
    }
    if ($stock.Count -lt 5) { Stop-Setup "Could not read the stock EditPackages from '$gameIni'." }

    $out = New-Object System.Collections.Generic.List[string]
    $section = ''
    $wrotePackages = $false
    foreach ($l in $lines) {
        if ($l -match '^\s*\[(.+)\]\s*$') { $section = $Matches[1]; $out.Add($l); continue }
        if ($section -eq 'Core.System') {
            if ($l -match '^\s*Paths\s*=') { continue }
            if ($l -match '^\s*CacheRecordPath\s*=') {
                # Paths of this build folder only. CacheRecordPath must stay here, or UCC writes .ucl files into the game.
                $out.Add('CacheRecordPath=../System/*.ucl')
                $out.Add('Paths=../System/*.u')
                $out.Add('Paths=../Textures/*.utx')
                $out.Add('Paths=../Sounds/*.uax')
                $out.Add('Paths=../Music/*.umx')
                $out.Add('Paths=../StaticMeshes/*.usx')
                $out.Add('Paths=../Animations/*.ukx')
                continue
            }
        }
        if ($section -eq 'Editor.EditorEngine' -and $l -match '^\s*EditPackages\s*=') {
            if (-not $wrotePackages) {
                $list = New-Object System.Collections.Generic.List[string]
                foreach ($p in $stock) { $list.Add($p) }
                foreach ($p in $Packages) {
                    foreach ($d in @($Dependencies[$p])) {
                        if (-not $d -or $list.Contains($d)) { continue }
                        if (-not (Test-Path -LiteralPath (Join-Path $sys "$d.u"))) {
                            Stop-Setup "$p needs $d.u, which is not in '$GameDir\System'."
                        }
                        $list.Add($d)
                    }
                    $list.Add($p)
                }
                foreach ($p in $list) { $out.Add("EditPackages=$p") }
                $wrotePackages = $true
            }
            continue
        }
        $out.Add($l)
    }
    Set-Content -LiteralPath (Join-Path $sys 'BWCompileCheck.ini') -Value $out -Encoding Default
}

# ---------------------------------------------------------------- one compile

function Invoke-Compile([string]$SourceRoot, [string[]]$Packages, [string]$Label) {
    $sys = Join-Path $WorkDir 'System'
    foreach ($p in $Packages) {
        foreach ($ext in 'u', 'ucl') {
            $f = Join-Path $sys "$p.$ext"
            if (Test-Path -LiteralPath $f) { Remove-Item -LiteralPath $f -Force }
        }
        # A plain copy of each package folder (never a link: the folder is mirrored, so extra files are deleted).
        $null = & robocopy (Join-Path $SourceRoot $p) (Join-Path $WorkDir $p) /MIR /R:1 /W:1 /NFL /NDL /NJH /NJS /NP
        if ($LASTEXITCODE -ge 8) { Stop-Setup "Copying the $p source failed (robocopy exit code $LASTEXITCODE)." }
    }

    $log = Join-Path $WorkDir "$Label.log"
    Write-Host "Compiling $Label ($($Packages.Count) packages)..."
    $proc = Start-Process -FilePath (Join-Path $sys 'UCC.exe') -ArgumentList 'make', 'ini=BWCompileCheck.ini' `
        -WorkingDirectory $sys -RedirectStandardOutput $log -RedirectStandardError "$log.err" -NoNewWindow -PassThru
    if (-not $proc.WaitForExit($TimeoutSeconds * 1000)) {
        $proc.Kill()
        Stop-Setup "UCC make ($Label) took longer than $TimeoutSeconds seconds and was stopped. Log: $log"
    }

    $text = (Get-Content -LiteralPath $log -Raw) + "`n" + (Get-Content -LiteralPath "$log.err" -Raw -ErrorAction SilentlyContinue)
    # Paths are printed in the build folder; keep them from the package folder on, as in the repository.
    $pkgPattern = '^.*?[\\/](?=(' + (($Packages | ForEach-Object { [regex]::Escape($_) }) -join '|') + ')[\\/])'
    $messages = @()
    foreach ($line in ($text -split "[`r`n]+")) {
        $l = $line.Trim()
        if ($l -eq '') { continue }
        $skip = $false
        foreach ($n in $NoisePatterns) { if ($l -like "*$n*") { $skip = $true } }
        if ($skip) { continue }
        if ($l -match '^(?<file>.+?\.uc)\((?<line>\d+)\)\s*:\s*(?:[^:]+:\s*)?(?<kind>Error|Warning),?\s*(?<msg>.*)$') {
            if ($Matches.msg -match '^Failure - ') { continue }  # the closing count, not an error of its own
            $file = ($Matches.file -replace $pkgPattern, '') -replace '\\', '/'
            $messages += [pscustomobject]@{ Kind = $Matches.kind; File = $file; Line = [int]$Matches.line; Message = $Matches.msg }
        }
        elseif ($l -match '^(?<pkg>\w+)\.(?<cls>\w+):\s+(?<msg>.+)$' -and $Packages -contains $Matches.pkg) {
            # Messages about a class's defaults, e.g. "BallisticProV55.M50AssaultRifle: Unknown property in defaults: Foo=1".
            $pkg = $Matches.pkg; $msg = $Matches.msg -replace '\s+', ' '
            $kind = if ($msg -match '\bError\b') { 'Error' } else { 'Warning' }
            $file = ''; $lineNo = 0
            $uc = Get-ChildItem -LiteralPath (Join-Path (Join-Path $WorkDir $pkg) 'Classes') -Filter "$($Matches.cls).uc" -ErrorAction SilentlyContinue | Select-Object -First 1
            if ($uc) {
                $file = "$pkg/Classes/$($uc.Name)"
                $needle = ($msg -split ':')[-1].Trim()
                if ($needle) {
                    $hit = Select-String -LiteralPath $uc.FullName -SimpleMatch -Pattern $needle | Select-Object -First 1
                    if ($hit) { $lineNo = $hit.LineNumber }
                }
            }
            $messages += [pscustomobject]@{ Kind = $kind; File = $file; Line = $lineNo; Message = $msg }
        }
        elseif ($l -match '^(Error|Warning)\b[,:]?\s*(.*)$' -or $l -match '^(Critical error|Failure)\b(.*)$') {
            $kind = if ($Matches[1] -eq 'Warning') { 'Warning' } else { 'Error' }
            if ($l -match '^Failure - ') { continue }  # the summary line; the errors themselves are listed above it
            $messages += [pscustomobject]@{ Kind = $kind; File = ''; Line = 0; Message = $l }
        }
    }
    $ok = $text -match 'Success - 0 error'
    if (-not $ok -and -not ($messages | Where-Object Kind -eq 'Error')) {
        $tail = (($text -split "[`r`n]+") | Where-Object { $_.Trim() } | Select-Object -Last 5) -join ' | '
        $messages += [pscustomobject]@{ Kind = 'Error'; File = ''; Line = 0; Message = "UCC did not report success: $tail" }
    }
    return [pscustomobject]@{ Ok = $ok; Messages = $messages; Log = $log }
}

# Warnings of $Head that $Base doesn't have. Line numbers move, so a warning is its file plus its text, counted.
function Get-NewWarnings($Head, $Base) {
    $seen = @{}
    foreach ($w in ($Base.Messages | Where-Object Kind -eq 'Warning')) {
        $k = "$($w.File)|$($w.Message)"
        $seen[$k] = 1 + [int]$seen[$k]
    }
    $new = @()
    foreach ($w in ($Head.Messages | Where-Object Kind -eq 'Warning')) {
        $k = "$($w.File)|$($w.Message)"
        if ([int]$seen[$k] -gt 0) { $seen[$k] = [int]$seen[$k] - 1 } else { $new += $w }
    }
    return $new
}

function Format-Location($m) {
    if ($m.File -and $m.Line) { return "$($m.File)($($m.Line))" }
    if ($m.File) { return $m.File }
    return '(no file)'
}

function ConvertTo-AnnotationText([string]$s) {
    return $s.Replace('%', '%25').Replace("`r", '%0D').Replace("`n", '%0A')
}

# ---------------------------------------------------------------- main

if (-not $Source) { $Source = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path) }
$Source = (Resolve-Path -LiteralPath $Source).Path
$GameDir = (Resolve-Path -LiteralPath $GameDir).Path
$packages = Get-Packages $Source
if ($packages.Count -eq 0) { Stop-Setup "No package folders with a Classes folder in '$Source'." }

Initialize-WorkDir $packages
Write-BuildIni $packages

$base = $null
if ($Compare) {
    & git -C $Source rev-parse --verify --quiet "$Compare^{commit}" > $null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Note: '$Compare' is not a commit in this checkout (force push?); compiling without a comparison."
        $Compare = ''
    }
}
if ($Compare) {
    $baseSrc = Join-Path $WorkDir 'base-src'
    if (Test-Path -LiteralPath $baseSrc) {
        & git -C $Source worktree remove --force $baseSrc 2>$null
        if (Test-Path -LiteralPath $baseSrc) { Remove-Item -LiteralPath $baseSrc -Recurse -Force }
    }
    & git -C $Source worktree prune
    & git -C $Source worktree add --detach --quiet $baseSrc $Compare
    if ($LASTEXITCODE -ne 0) { Stop-Setup "git could not check out '$Compare'." }
    try {
        $basePackages = @(Get-Packages $baseSrc | Where-Object { $packages -contains $_ })
        $base = Invoke-Compile $baseSrc $basePackages 'base'
    }
    finally {
        & git -C $Source worktree remove --force $baseSrc
    }
    if (-not $base.Ok) { Write-Host "Note: $Compare does not compile by itself, so every warning is listed below." }
}

$head = Invoke-Compile $Source $packages 'head'
$errors = @($head.Messages | Where-Object Kind -eq 'Error')
$allWarnings = @($head.Messages | Where-Object Kind -eq 'Warning')
if ($base -and $base.Ok) { $warnings = @(Get-NewWarnings $head $base); $warnWord = 'new warning(s)' }
else { $warnings = $allWarnings; $warnWord = 'warning(s)' }

# Console
Write-Host ''
foreach ($m in $errors) { Write-Host "ERROR   $(Format-Location $m): $($m.Message)" -ForegroundColor Red }
foreach ($m in $warnings) { Write-Host "WARNING $(Format-Location $m): $($m.Message)" -ForegroundColor Yellow }
$verdict = if ($head.Ok) { 'COMPILES' } else { 'DOES NOT COMPILE' }
Write-Host ("{0}: {1} error(s), {2} {3}{4}. Log: {5}" -f $verdict, $errors.Count, $warnings.Count, $warnWord,
    $(if ($Compare -and $base.Ok) { " compared with $Compare" } else { '' }), $head.Log)

# GitHub: annotations on the changed lines and a summary on the run's page
if ($InActions) {
    foreach ($m in $errors + $warnings) {
        $kind = $m.Kind.ToLower()
        $msg = ConvertTo-AnnotationText $m.Message
        if ($m.File -and $m.Line) { Write-Output "::${kind} file=$($m.File),line=$($m.Line),title=UCC $($m.Kind)::$msg" }
        elseif ($m.File) { Write-Output "::${kind} file=$($m.File),title=UCC $($m.Kind)::$msg" }
        else { Write-Output "::${kind} title=UCC $($m.Kind)::$msg" }
    }
    if ($env:GITHUB_STEP_SUMMARY) {
        $md = New-Object System.Collections.Generic.List[string]
        $icon = if ($head.Ok) { ':white_check_mark:' } else { ':x:' }
        $md.Add("## $icon UCC make: $($verdict.ToLower())")
        $md.Add('')
        $cmp = if ($Compare -and $base.Ok) { " (compared with ``$Compare``)" } else { '' }
        $md.Add("$($errors.Count) error(s), $($warnings.Count) $warnWord$cmp. Packages: $($packages -join ', ').")
        if ($errors.Count + $warnings.Count -gt 0) {
            $md.Add('')
            $md.Add('| | Where | Message |')
            $md.Add('|---|---|---|')
            foreach ($m in $errors + $warnings) {
                $md.Add("| $($m.Kind) | ``$(Format-Location $m)`` | $($m.Message.Replace('|', '\|')) |")
            }
        }
        if (-not $head.Ok) {
            $md.Add('')
            $md.Add('If the errors name textures, sounds or meshes the code can''t find, this change may need asset packages the build machine does not have yet.')
        }
        Add-Content -LiteralPath $env:GITHUB_STEP_SUMMARY -Value $md -Encoding UTF8
    }
}

if ($head.Ok) { exit 0 } else { exit 1 }
