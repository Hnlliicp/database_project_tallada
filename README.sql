/*
Git Repository:

Terminal Commands: PUSH

git add .
    git commit -m"Comment here"
        git push (This pushes the new version update)

Terminal Commands: PULL

git pull
    git checkout -b your-brach-name (hanley-feature) (this means to create a new branch and switch into it immediately)

    At this point you are no longer on main, every edit/commit will belong to: hanley-feature.
    Make your changes (either schema queris, etc.) then commit changes.

        git add .
            git commit -m"Added delivery service entity"
                git push origin your-branch-name (hanley-feature) (this means to push YOUR own branch which is important)

                Open GitHub, Repo, Compare & pull request, Add Title, Description, then create pull request
                Merge Pull request by either you or repo owner (tallada) click MERGE PULL REQUEST, now your branch changes enter MAIN.

                This is a safer approach rather that everyone editing on MAIN directly: 
                This isolates work
                easier conflict handling
                review system
                safer collaboration

*/;
