assertPageContains() {
if (curl -s http://localhost:8000$1 | grep "$2" > /dev/null); then
    echo "pass"
else
    echo "fail"
fi
}
ghc --make Main.hs || exit
./Main &
serverPid=$!
sleep 1
assertPageContains "/" "3"
kill -9 $serverPid
