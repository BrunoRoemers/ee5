> This repository contains my contribution to EE5 as part of my bachelor's degree. The Git history has been purged for privacy reasons.

# Useful Learning Resources
https://www.ruby-lang.org/en/documentation/quickstart/
https://guides.rubyonrails.org/getting_started.html

# Adminer Schema Permanent Link
http://localhost:8080/?pgsql=db&username=rails&db=server_development&ns=public&schema=milestone_types%3A12.7083x8.0556_doctor_appointments%3A56.4583x-1.6667_group_activities%3A48.2639x24.3056_diary_entries%3A47.9861x-1.6667_milestones%3A23.75x7.1528_responsibilities%3A39.2361x11.5278_responsibility_types%3A50x10.6944_schema_migrations%3A1.1111x12.0139_sport_bans%3A24.1667x-1.6667_stays%3A34.3056x24.3056_users%3A17.4306x23.8194_violations%3A38.3333x-1.6667

# Shortcuts
- `make build`: build the server and db
- `make up`: run server and db in background
- `make down`: stop server and db
- `make up?`: check if server and/or db are running
- `make server`: enter inside the server container
    - Note: Docker containers are **stateless**, so any changes made inside
    the container will be lost when the container stops. Only changes written
    to a volume (`/server` inside `server`, `//var/lib/postgresql/data`
    inside `db`) will persist.
- `make db`: enter inside the server container
- `make .env`: generate the `.env` file

# Install Prerequisites (Linux)
## Git
(Should be installed by default on Ubuntu)


## Install Docker
(adapted from: https://docs.docker.com/install/linux/docker-ce/ubuntu/)

NOTE: Make sure to uninstall older versions of Docker (see link)!

1. install prerequisites: `sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common`
2. add Docker GPG key: `curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -`
3. make sure GPG key is installed correctly: `apt-key fingerprint 0EBFCD88`
4. add Docker's repository: `sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"`
5. `sudo apt update`
6. `sudo apt install docker-ce docker-ce-cli containerd.io`
7. test Docker: `sudo docker run hello-world`
8. add your user to the Docker group: `sudo usermod -aG docker $USER`
9. close current terminal and open a new one (for changes to take effect)
10. Test Docker without sudo (admin permissions): `docker run hello-world`
    - If this gives an error, try a complete reboot and the `docker` group to your user again.

## Docker Compose
1. `sudo apt install docker-compose`

NOTE: this does not install the latest available version, but it will do the job. Alternatively, check Step 2 of: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-14-04

2. Set up your environment variables, so that the docker container runs as the user on the host machine: `make .env`


# Set up your local development environment
1. Make sure to add an ssh key to your BitBucket account (account settings -> ssh-keys). The instructions to generate such key can be found e.g. here: https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
2. get a copy of the git repo: `git clone git@bitbucket.org:c0d0g3n/ee5.git`
3. move into the project folder: `cd ee5`
4. build the project: `docker-compose build` (takes a long time)
5. install yarn packages: `docker-compose run server rails yarn:install`
6. create a local database (hosted inside Docker): `docker-compose run server rails db:create`
7. start the server: `docker-compose up`
8. visit the homepage at http://localhost:3000 (don't forget port 3000!)
    - NOTE: The port can be changed in `.env`, generated by `make .env`.
9. stop the server: `docker-compose down` (or `ctrl+c` when docker-compose is running in the foreground)
10. Seed the database with demo data: `docker-compose run server rails db:seed`.

LINUX TIP: I created a symbolic link for docker-compose: first find where docker-compose is installed (`which docker-compose`). Move to that folder and create a symbolic link like this: `sudo ln -s docker-compose dc`. Now instead of `docker-compose`, type `dc`.

CODE QUALITY TIP: This repo is configured to use Rubocop (https://docs.rubocop.org/en/stable/).
Install the Rubocop plugin for your editor (supported editors: https://docs.rubocop.org/en/stable/integration_with_other_tools/) and help ensure code quality.


# Docker commands
- start server: `docker-compose up`
    - start server as daemon: `docker-compose up -d`
- stop server: `docker-compose down`
    - alternatively press `ctrl+c` when Docker is running in the foreground
- run arbitrary command on server: `docker-compose run server <command>`
    - interactive shell: `docker-compose run server bash`
- rebuild server (e.g. to install extra components): `docker-compose build`


# Git Tips
- Atomic commits: https://www.freshconsulting.com/atomic-commits/
- Clear and concise commit messages: https://chris.beams.io/posts/git-commit/
    - NOTE: If you're inclined to write `and` in your commit message, that may be a sign that your commit is not really atomic.
- Commit often = loose less work
- Create a feature branch for each new feature
- The master branch contains only working code
- Communicate what you are working on, to reduce the chance of complex merges and redundant work
- Team members work on different features to reduce the chance of merges
- Change your terminal's prompt ($PS1 on Linux) to show git status and the current branch name

# Git Workflow
1. When starting a coding session, execute `git pull <remote> <branch>` to start with the most up-to-date version of our code base. (Fetch other's work from the cloud)
1. (May have to migrate the database after some changes, I don't know yet how rails handles this exactly)
1. Do some work
1. Test your work
1. Check what changes you've made, what is (not) staged, what branch, ahead/behind...: `git status`
1. Stage your work: `git add <path to file or folder>`
    - to stage all changes in your working directory: `git add .`
1. Commit your work: `git commit` (This opens your editor and allows you to type a commit message, the commit will go through after the file is saved and closed. It is always possible to abort before committing by hitting `ctrl+c` in the terminal.)
    - Atomic and concise commits!
    - Forgot to add something to your commit? `git commit -amend`
1. Push your work so the team can see it: `git push <remote> <branch>`
1. When behind on the remote branch, rebase: `git pull --rebase <remote> <branch>` (afterwards try to push again)
1. View the most recent commits: `git log`
1. View a particular commit in detail: `git show <first few letters of commit hash>`
1. Find more help about a command: `man <command>`, `<command> --help`, `git help <git command>`...

# Git Branching
> Use a separate branch for each new feature

concept explained: https://youtu.be/0iuqXh0oojo
The ideal world: https://nvie.com/posts/a-successful-git-branching-model/
More workflows: https://www.atlassian.com/git/tutorials/comparing-workflows

1. create a new branch: `git branch <new branch name>`
    - e.g. `git branch feature/user-login` (note the convention; start a feature branch with `feature/`)
1. change branches: `git checkout <branch>`
    - create and move to branch at once: `git checkout -b <branch>`
1. merge branches (run while the destination branch is active): `git merge --no-ff <branch from which commits will be imported>`
    - `--no-ff` disables fast forwarding and hence preserves as much of the branches history as possible
1. remove a branch: `git branch -d <branch>`

# FAQ
## How do I start working on a new feature?
Best practice is to create a new branch.
That way you are not bothered by the changes of other people and the master
branch remains uncluttered and stable.

1. Create and move to a new branch: `git checkout -b feature/<your-feature-name>`.
1. Develop the feature and create atomic commits during the process.
1. You can even mirror your feature on Bitbucket: `git push -u origin feature/<your-feature-name>`
1. [TODO: Ask for a merge]

## I completed an atomic work package, how do I turn it into a commit?
1. Run `git status -u`, this will give you an **overview of the changes** you've made.

    - Note: the `-u` flag (optional) ensures that all new/changed files are shown,
    instead of being grouped by the parent folder.

1. Check the new/edited files to make sure they relate to each other (ensure that your commit will be **atomic**: https://www.freshconsulting.com/atomic-commits/).

1. Make sure that **no unwanted changes** are present.
(E.g. debug statements like `puts "test 123"`, or files that you do not need anymore.)

1. **Stage** your files: `git add <file path>`.

    - Stage all changes in your working directory
    (the one shown in the prompt of the termina): `git add .` (think about atomic commits!)

1. Create the **commit**: `git commit`. This opens a file called `COMMIT_EDITMSG`
   in the default git editor.

    - How to change your default git editor:
    https://www.git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#_code_core_editor_code
    (and other config options)

1. Type a commit message. The commit goes through after you save and close the file.

    - If you decide you do not want to commit, leave the file open, go to the terminal
    and hit `ctrl + c` to abort the commit process.
    - Write **proper commit messages**, see: https://chris.beams.io/posts/git-commit/.
    (By using `git log`, you can see how other teammates format their messages
    (hopefully correctly).)

1. In case you want to change your latest commit, go through staging again
   and commit the additional changes with `git commit -amend`.
   Note this is **not possible after you have pushed**!

1. You are now ready to **push** your commit! (see FAQ)


## I have a commit ready, how do I share the work with my team?
You need to push your work to Bitbucket,
so your team members can pull in the changes: `git push <remote> <branch>`.

During the process, you may be prompted to enter the password of your ssh key (the one you added to BitBucket).

## Git does not allow me to push commits, what do I do?
Your "error" looks similar to the following:

```
> git push <remote> <branch>
To bitbucket.org:c0d0g3n/ee5.git
 ! [rejected]        <branch> -> <branch> (fetch first)
error: failed to push some refs to 'git@bitbucket.org:c0d0g3n/ee5.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

This means somebody from your team was first to push a new commit to the server.
(Nice - a lot of work is being done!)

You will have to download (pull) their work first, and add your work on top of their changes.

Use the following command: `git pull --rebase <remote> <branch>`
(**replace** `<remote>` and `branch` with the values that apply to your system.)

Feel free to check the latest commits to see what your team has been working on
(and to assure the rebase was successful): `git log`.

Check the FAQ if pulling results in a **merge conflict**.

After you successfully rebased your commit on top of your team's work,
you can try to push again: `git push <remote> <branch>`.

## How do I deal with a merge conflict?
[TODO - put a message in the chat to get help]

## How do I find help about command line tools?
1. Try if the command has a **help flag**: `your-command --help`.
Usually this allows you to get very granular instructions for subcommands
(e.g. `rails generate controller --help`).

    - Note most commands return a man page when asked for help, see below how
    to navigate them.

1. Try if the command has a **help subcommand**: e.g. `git help branch`.

1. Try the **manual page** of a command: e.g. `man git`, `man git branch`.

    - While on a man page, hit `h` to show help about **how to navigate** a man page
    (as said in the bottom left corner of every man page). E.g. man pages are **searchable**!
    - Hit `q` to close the man page.

1. **Ask** a teammate.

1. Use the **internet**.
