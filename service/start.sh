pnpm install
nohup pnpm start > ../service.log 2>&1 &
echo $! > ../service.pid
echo "Start service complete!"

# sudo ss -ntlp | grep LISTEN        
# mac: lsof -i tcp:8081
