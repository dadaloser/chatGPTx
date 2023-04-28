kill $(cat ../service.pid)
rm ../service.pid
echo "Service stopped."

# sudo ss -ntlp | grep LISTEN        
