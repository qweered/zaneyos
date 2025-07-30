{ pkgs, config, ... }:
{
  home.packages = with pkgs; [ lazygit ];

  programs.gh.enable = true;

  programs.git = {
    enable = true;
    package = pkgs.gitMinimal.override { withLibsecret = true; }; # gitMinimal to remove perl
    userName = "Aliaksandr";
    userEmail = "grubian2@gmail.com";
    delta.enable = true;
    signing = {
      key = config.programs.gpg.settings.default-key;
      signByDefault = true;
    };
    aliases = {
      # Branch operations
      b = "branch --verbose";
      bd = "branch --delete";
      bD = "branch --delete --force";
      br = "branch --remote";
      ba = "branch --all";
      bm = "branch --merged";
      bnm = "branch --no-merged";

      # Modern checkout/switch commands
      sw = "switch";
      swc = "switch --create";
      rs = "restore";

      # Commit operations
      c = "commit";
      cm = "commit --message";
      ca = "commit --amend";
      can = "commit --amend --no-edit";
      cf = "commit --fixup";
      cs = "commit --squash";

      # Enhanced log aliases with better formatting
      # TODO: reverse order of logs
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      ll = "log --oneline --graph --decorate --all -20";
      ls = "log --stat";
      lol = "log --graph --decorate --pretty=oneline --abbrev-commit";

      # Status and diff
      s = "status --short --branch";
      st = "status";
      d = "diff";
      dt = "difftool --tool=nvimdiff --no-prompt";

      # Stash operations
      sl = "stash list";
      sp = "stash pop";
      ss = "stash push"; # modern alternative to stash save
      ssm = "stash push -m"; # stash with message
      ssu = "stash push --include-untracked";

      # Reset operations
      r = "reset";
      r1 = "reset HEAD^";
      r2 = "reset HEAD^^";
      rhard = "reset --hard";
      rsoft = "reset --soft";
      unstage = "reset HEAD --";

      # Remote operations
      f = "fetch";
      fa = "fetch --all";
      fo = "fetch origin";
      fp = "fetch --prune";
      p = "push";
      po = "push origin";
      pu = "push --set-upstream origin HEAD";
      pf = "push --force-with-lease"; # safer than --force

      # Pull operations
      pl = "pull";
      plr = "pull --rebase";
      plo = "pull origin";

      # Rebase operations
      rb = "rebase";
      rbi = "rebase --interactive";
      rbc = "rebase --continue";
      rba = "rebase --abort";
      rbs = "rebase --skip";

      # Merge operations (I don't use merge)
      # m = "merge";
      # mnf = "merge --no-ff";
      # mff = "merge --ff-only";

      # Add operations
      a = "add";
      aa = "add --all";
      ap = "add --patch";

      # Utility aliases
      ds = "describe --long --tags --dirty --always";
      who = "shortlog --summary";
      alias = "config --get-regexp ^alias\\. | cut -d' ' -f2-";
      last = "log --oneline --stat HEAD";
      visual = "!gitk";
      today = "log --since='1 day ago' --oneline --author=$(git config user.email)";
      yesterday = "log --since='2 days ago' --until='1 day ago' --oneline --author=$(git config user.email)";

      # Cleanup aliases
      cleanup = "!git branch --merged | grep -v '\\*\\|main\\|master\\|develop' | xargs -n 1 git branch -d";
      prune-branches = "!git remote prune origin && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -d";

      # Workflow aliases
      wip = "commit -am 'WIP: work in progress'";
      unwip = "reset HEAD~1";
      assume = "update-index --assume-unchanged";
      unassume = "update-index --no-assume-unchanged";
      assumed = "!git ls-files -v | grep ^h | cut -c 3-";
    };
    extraConfig = {
      # Branch settings
      branch.autoSetupRebase = "always";
      branch.sort = "-committerdate";

      # Blame settings
      blame.coloring = "repeatedLines";
      blame.markUnblamables = true;
      blame.markIgnoredLines = true;
      blame.date = "relative";

      # Color settings
      color.ui = true;
      color.pager = true;
      color.branch = "auto";
      color.diff = "auto";
      color.status = "auto";

      # Core settings
      core.untrackedCache = true;
      core.preloadindex = true;
      core.fscache = true; # Windows performance
      core.editor = "nvim";
      core.autocrlf = false;
      core.safecrlf = false;
      core.fileMode = true;
      core.ignorecase = false;

      # Credential settings
      credential.helper = "libsecret";

      # Diff settings
      diff.algorithm = "histogram";
      diff.colorMoved = "default";
      diff.colorMovedWS = "allow-indentation-change";
      diff.mnemonicPrefix = true;
      diff.renames = "copies";
      diff.tool = "nvimdiff";

      # Feature settings
      feature.experimental = true;
      feature.manyFiles = true;

      # Fetch settings
      fetch.prune = true;
      fetch.pruneTags = true;
      fetch.parallel = 0; # use all available cores

      # GitHub settings
      github.user = "qweered";

      # Init settings
      init.defaultBranch = "main";

      # Index settings
      index.sparse = true;
      index.threads = true;

      # Log settings
      log.date = "relative";
      log.decorate = "short";
      log.follow = true;

      # Maintenance settings
      maintenance.auto = true;

      # Merge settings
      merge.conflictstyle = "zdiff3"; # better than diff3
      merge.autoStash = true;
      merge.tool = "nvimdiff";
      merge.ff = false; # always create merge commits for feature branches

      # Pack settings for performance
      pack.threads = 0; # use all available cores
      pack.writeReverseIndex = true;

      # Push settings
      push.autoSetupRemote = true;
      push.default = "simple";
      push.followTags = true;
      push.useForceIfIncludes = true;

      # Pull settings
      pull.rebase = true;
      pull.twohead = "ort"; # new merge strategy

      # Rebase settings
      rebase.autoStash = true;
      rebase.autoSquash = true;
      rebase.updateRefs = true;

      # Rerere settings
      rerere.enable = true;
      rerere.autoUpdate = true;

      # Remote settings
      remote.origin.prune = true;

      # Status settings
      status.showUntrackedFiles = "all";
      status.submoduleSummary = true;

      # Submodule settings
      submodule.recurse = true;
      submodule.fetchJobs = 4;

      # Tag settings
      tag.sort = "version:refname";

      # Transfer settings for performance
      transfer.unpackLimit = 1;

      # URL shortcuts
      url = {
        "https://github.com/" = {
          insteadOf = [
            "gh:"
            "github:"
          ];
        };
        "https://gitlab.com/" = {
          insteadOf = [
            "gl:"
            "gitlab:"
          ];
        };
      };

      # Versionsort settings
      versionsort.suffix = [
        "-pre"
        ".pre"
        "-beta"
        ".beta"
        "-rc"
        ".rc"
      ];
    };
  };
}
