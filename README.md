# git-watcher

Small github webhook watcher service based ok (githubhook)[https://www.npmjs.com/package/githubhook].


# Install

Install githubhook (for Ubuntu/Debian)

```
curl -sL https://deb.nodesource.com/setup_4.x | sudo bash -
apt-get install -y nodejs
npm install -g githubhook
```

Configure git-watcher

```
mkdir -p /services/projects/git-watcher
git clone -b master https://github.com/mgruener/git-watcher.git /services/projects/git-watcher/master
```

Create `deploy.env`, `watcher.env` and `repos`

```
echo "NAMESPACE=whatever" > /services/projects/deploy.env
cat << EOF > /services/projects/watcher.env
SECRET=mysecret
PORT=1234
EOF
```

Install git watcher

```
/services/projects/git-watcher/master/prod.sh
```
# Config files

* `repos`: list of repositories git-watcher should react to
* `deploy.env`: contains the NAMESPACE (https://github.com/${NAMESPACE}/${REPO})
* `watcher.env`: contains the SECRET for github webhooks and the port to listen on

# Usage

When git-watcher has been configured, you have to create webhooks for in the settings
of your github projects:

* Payload: http://<yourhost>:<port>/github/callback
* Content type: application/json
* Secret: <secret>

where

* `<yourhost>` is the host running git-watcher
* `<port>` is the value of the `PORT` setting in watcher.env
* `<secret>` is the value of the `SECRET` setting in watcher.env

