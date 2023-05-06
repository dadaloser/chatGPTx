kill $(cat ../front.pid)
rm ../front.pid
echo "Front stopped."

# sudo ss -ntlp | grep LISTEN        
# mac: lsof -i tcp:8081
