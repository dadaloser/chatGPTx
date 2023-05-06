pnpm bootstrap
echo "" > ../front.log
nohup pnpm dev > ../front.log 2>&1 & 
echo $! > ../front.pid
echo "Start front complete!"
 
# sudo ss -ntlp | grep LISTEN        
#mac: lsof -i tcp:8081




