{ pkgs, config, ... }:
{
  home.packages = with pkgs; [ lazygit graphite-cli jujutsu ];

  programs.gh.enable = true;

  programs.git = {
    enable = true;
    package = pkgs.gitMinimal.override { withLibsecret = true; }; # gitMinimal to remove perl
    delta.enable = true;
    userName = "Aliaksandr";
    userEmail = "grubian2@gmail.com";
    signing = {
      key = config.programs.gpg.settings.default-key;
      signByDefault = true;
    };
    attributes = [
      # CONFIG: Add some diff configs if diff will annoy me
      "* text=auto"
      # Lock files – avoid conflicts
      "bun.lock          merge=ours"
      "package-lock.json merge=ours"
      "pnpm-lock.yaml    merge=ours"
      "yarn.lock         merge=ours"
      "Cargo.lock        merge=ours"
    ];
    aliases = {
      # Add / delete files
      aa = "add --all";
      ap = "add --patch";
      unstage = "reset HEAD --";
      unwip = "reset HEAD~1";
      rhard = "reset --hard";
      rsoft = "reset --soft";
      r2 = "reset HEAD^^";
      r3 = "reset HEAD^^^";
      # TODO: stash aliases
      # TODO: migrate to jj? Map jj to gg for comfort

      # Commits
      c = "commit";
      ca = "commit --amend";
      caan = "commit --all --amend --no-edit";
      can = "commit --amend --no-edit"; # less popular so longer
      wip = "commit --amend --message 'WIP: work in progress'";
      caf = "commit --all --fixup HEAD";

      # Work with branches
      b = "branch -vv";
      bd = "branch --delete";
      bD = "branch --delete --force";
      br = "branch --remote";
      ba = "branch --all";
      bm = "branch --merged";
      bnm = "branch --no-merged";
      sw = "switch";
      swc = "switch --create";
      pf = "push --force-with-lease"; # safer than --force

      # delete local merged branches
      cleanup = "!git branch --merged | grep -v '\\*\\|main\\|master\\|develop\\|stable' | xargs -r -n 1 git branch -d";
      # delete remote merged branches, VERY DANGEROUS
      cleanup-remote = "!git branch -r --merged | grep -v -E '\\*\\s|main|master|develop|stable' | sed -e 's/origin\\///' | xargs -r -n 1 git push origin --delete";
      # delete local removed branches
      prune-branches = "!git branch -vv | grep ': gone]' | awk '{print \$1}' | xargs -r -n 1 git branch -d";
      full-cleanup = "!git cleanup && git prune-branches";

      # TODO: checked up to here
      # TODO: reverse order of logs
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      ll = "log --oneline --graph --decorate --all -20";
      ls = "log --stat";
      lol = "log --graph --decorate --pretty=oneline --abbrev-commit";

      s = "status --short --branch";
      st = "status";
      dc = "diff HEAD"; # current staged diff
      dp = "diff HEAD~1 HEAD"; # previous commit diff
      dcv = "difftool HEAD --tool=nvimdiff --no-prompt";
      dpv = "difftool HEAD~1 HEAD --tool=nvimdiff --no-prompt";

      # Stash operations
      sl = "stash list";
      sp = "stash pop";
      ss = "stash push"; # modern alternative to stash save
      ssm = "stash push -m"; # stash with message
      ssu = "stash push --include-untracked";

      # Remote operations
      f = "fetch";
      fa = "fetch --all";
      fo = "fetch origin";
      p = "push";
      po = "push origin";
      pod = "push origin --delete";
      pu = "push --set-upstream origin HEAD";
      pl = "pull";
      plr = "pull --rebase";
      plo = "pull origin";

      # Rebase operations
      rb = "rebase";
      rbi = "rebase --interactive";
      rbc = "rebase --continue";
      rba = "rebase --abort";
      rbs = "rebase --skip";
      rs = "restore";

      # Merge operations (I don't use merge)
      # m = "merge";
      # mnf = "merge --no-ff";

      # Utility aliases
      ds = "describe --long --tags --dirty --always";
      who = "shortlog --summary";
      last = "log --oneline --stat HEAD";
      visual = "!gitk";
      today = "log --since='1 day ago' --oneline --author=$(git config user.email)";
      yesterday = "log --since='2 days ago' --until='1 day ago' --oneline --author=$(git config user.email)";

      # Workflow aliases
      assume = "update-index --assume-unchanged";
      unassume = "update-index --no-assume-unchanged";
      assumed = "!git ls-files -v | grep ^h | cut -c 3-";
    };
    extraConfig = {
      github.user = "qweered";
      core.editor = "nvim";
      feature.experimental = true;
      credential.helper = "libsecret";

      # Auto prune # TODO: slow for eg nixpkgs
      # fetch.prune = true;
      # fetch.pruneTags = true;
      # remote.origin.prune = true;

      # Performance
      core.fsmonitor = true; # will benefit when support linux
      feature.manyFiles = true;
      fetch.writeCommitGraph = true;
      fetch.parallel = 0; # use all available cores

      blame.coloring = "repeatedLines";
      blame.date = "relative";
      blame.markUnblamables = true;
      blame.markIgnoredLines = true;
      branch.autoSetupRebase = "always";
      branch.sort = "-committerdate";
      checkout.defaultRemote = "origin";
      color.ui = "auto"; # always breaks some aliases
      column.ui = "auto";
      diff.algorithm = "histogram";
      diff.colorMoved = "plain";
      diff.mnemonicPrefix = true;
      diff.renames = "copies";
      diff.tool = "nvimdiff";
      fetch.all = "true";
      init.defaultBranch = "main";
      log.date = "relative";
      log.decorate = "auto";
      log.follow = true;
      merge.conflictstyle = "zdiff3"; # better than diff3
      merge.autoStash = true;
      merge.tool = "nvimdiff";
      merge.ff = "only"; # try to not crate merge commits

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

      # TODO: check everything below https://git-scm.com/docs/git-config#Documentation/git-config.txt-pullff

      # Push settings
      push.autoSetupRemote = true;
      push.default = "simple";
      push.followTags = true;
      push.useForceIfIncludes = true;

      # Pull settings
      pull.rebase = true;

      # Rebase settings
      rebase.autoStash = true;
      rebase.autoSquash = true;
      rebase.updateRefs = true;

      # Rerere settings
      rerere.enable = true;
      rerere.autoUpdate = true;

      # Remote settings

      # Status settings
      status.showUntrackedFiles = "all";
      status.submoduleSummary = true;

      # Submodule settings
      submodule.recurse = true;
      submodule.fetchJobs = 4;

      # Tag settings
      tag.sort = "version:refname";
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
