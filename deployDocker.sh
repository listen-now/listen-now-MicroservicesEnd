echo "                                                                           "
echo ' _      _____  _____ _______ ______ _   _        _   _  ______          __ '
echo '| |    |_   _|/ ____|__   __|  ____| \ | |      | \ | |/ __ \ \        / / '
echo '| |      | | | (___    | |  | |__  |  \| |______|  \| | |  | \ \  /\  / /  '
echo '| |      | |  \___ \   | |  |  __| | . ` |______| . ` | |  | |\ \/  \/ /   '
echo '| |____ _| |_ ____) |  | |  | |____| |\  |      | |\  | |__| | \  /\  /    '
echo '|______|_____|_____/   |_|  |______|_| \_|      |_| \_|\____/   \/  \/     '
echo '                                                                           '
echo '                                                                           '

printf "${GREEN}"
echo '  _____ _   _  _____ _______       _      _      _____ _   _  _____       '
echo ' |_   _| \ | |/ ____|__   __|/\   | |    | |    |_   _| \ | |/ ____|      '
echo '   | | |  \| | (___    | |  /  \  | |    | |      | | |  \| | |  __       '
echo '   | | | . ` |\___ \   | | / /\ \ | |    | |      | | | . ` | | |_ |      '
echo '  _| |_| |\  |____) |  | |/ ____ \| |____| |____ _| |_| |\  | |__| |_ _ _ '
echo ' |_____|_| \_|_____/   |_/_/    \_\______|______|_____|_| \_|\_____(_|_|_)'
echo '                                                                          '
printf "${NORMAL}"

echo Install docker-ce.
wget https://raw.githubusercontent.com/import-yuefeng/ShadowsocksDocker/master/installDocker.sh
chmod +x installDocker.sh
source ./installDocker.sh

echo Pull required docker images.

docker pull catone/listen-now-uwsgi-python3:0.0.1
docker pull catone/listen-now-redis:0.0.1
docker pull catone/listen-now-nginx:0.0.1
docker pull catone/listen-now-mongodb:0.0.1

echo Pull Success!
echo Ready deploy listen-now-End.

docker run -d --name="redis.app" catone/listen-now-redis:0.0.1
docker run -d --name="mongodb.app" catone/listen-now-mongodb:0.0.1

docker run -d --name="uwsgi.app" --link redis.app --link mongodb.app catone/listen-now-uwsgi-python3:0.0.1

docker run -d -p 80:80 --name="nginx.app" --link uwsgi.app catone/listen-now-nginx:0.0.1

echo Deploy success.
echo Beybey.







