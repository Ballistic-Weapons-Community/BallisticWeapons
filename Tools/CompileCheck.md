# Compile check

`Tools/CompileCheck.ps1` compiles the Ballistic Weapons packages with `ucc make` and lists the errors, plus the
warnings a change adds. It runs on your own PC before you open a pull request, and on GitHub for every pull
request into `dev` or `master` once a build machine is set up (below).

It compiles BCoreProV55, BallisticProV55, BWBP_SKC_Pro, BWBP_OP_Pro, BWBP_JCF_Pro, BWBP_SWC_Pro,
BWBPAirstrikesPro, BWBP_APC_Pro, BWBP_VPC_Pro, BWInteractions3 and GunGameBW, in that order. `Legacy code`,
`Ballistic Weapons Singleplayer mode` and BWBP_JWC_Pro aren't part of the release build and are left out.

## On your own PC

You need UT2004 with Ballistic Weapons installed: the code refers to the BW texture, sound and mesh packages,
which aren't in this repository.

```
powershell -ExecutionPolicy Bypass -File Tools\CompileCheck.ps1 -GameDir C:\UT2004 -Compare upstream/dev
```

- `-GameDir`: the game folder. It is only read from, never written to.
- `-Compare`: a branch or commit to compare with. The packages are compiled from there first, and only warnings
  your change adds are listed. Leave it out to list every warning.
- `-WorkDir`: where it builds. Default: `%LOCALAPPDATA%\BWCompileCheck` (or `BW_COMPILE_WORKDIR` if set).

The first run copies the game's System folder there (about 650 MB); after that each compile takes about half a
minute. The build folder links the game's Textures, Sounds, StaticMeshes, Animations and Music folders as
junctions. **To delete the build folder, first remove those five links with `rmdir` in cmd**: some tools delete
what a junction points to, which would be the game's own folders.

Exit code 0: it compiles. 1: it does not. 2: the check could not run (the message says why).

## On GitHub

`.github/workflows/compile-check.yml` runs the same script on a self-hosted runner: a Windows PC with UT2004 and BW
installed, since the BW asset packages can't go on GitHub's machines. Results show as a check on the pull request,
with errors and new warnings marked on the changed lines and a table on the run's summary page. Until the
repository variable below is set, the workflow is skipped and nothing waits for it.

Setting up a build machine (needs admin rights on the repository):

1. On the PC that will build: Settings → Actions → Runners → **New self-hosted runner** → Windows, and follow the
   commands GitHub shows. When `config.cmd` asks for extra labels, enter `bw-compile`. A normal (non-admin)
   Windows account is enough and is safer.
2. In the runner's folder, create a file `.env` with the game folder in it, for example:
   ```
   BW_GAME_DIR=C:\UT2004
   ```
   Optionally also `BW_COMPILE_WORKDIR=D:\BWCompileCheck` to build somewhere other than `%LOCALAPPDATA%`.
   Use an install with the current BW release; a pull request that needs newer asset packages fails until this
   install has them.
3. Start the runner with `run.cmd` (checks run while that window is open), or let `config.cmd` install it as a
   service.
4. Settings → Secrets and variables → Actions → **Variables** → New repository variable `BW_COMPILE_RUNNER` with
   the value `true`.
5. Settings → Actions → General → *Fork pull request workflows from outside collaborators* → **Require approval for
   all outside collaborators**. A pull request can change the workflow and run commands on the build PC, so a run
   from someone outside the team should only be approved after reading what the pull request changes in
   `.github/` and `Tools/`.

If the PC is off, checks wait in the queue (up to a day) and run when it comes back.

# Closing issues fixed on dev

GitHub only closes the issues a pull request fixes when it is merged into the default branch (`master`).
`.github/workflows/close-fixed-issues.yml` does the same for pull requests merged into `dev`: it closes each issue
named with a closing keyword in the pull request's description or commit messages, with a comment pointing to
the pull request. Write `Fixes #123` (or closes / resolves), one keyword per issue: `Fixes #1, fixes #2`.
A plain mention like "#123" is left alone, so issues that should stay open until a release can still be
mentioned without closing them.
