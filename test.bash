assertPageContains() {
    if (curl -s http://localhost:8000$1 | grep "$2" > /dev/null); then
        echo "pass"
    else
        echo "fail"
    fi
}

dropVisitors() {
    mongo --eval "db.visitors.drop()" > /dev/null
}

addVisitor() {
    mongo --eval "db.visitors.insert({})" > /dev/null
}

testVisitorCountShowUpOnPage() {
    dropVisitors
    addVisitor
    addVisitor
    addVisitor
    assertPageContains "/" "3"
}

ghc --make Main.hs || exit
./Main &
serverPid=$!
sleep 1

testVisitorCountShowUpOnPage

kill -9 $serverPid
