In order to use a second webcam in fluidd :
1: Setup the second webcam and ensure it works with mjpg streamer
2: start mjpg streamer on another port with the second webcam (here a picam on port 8081:
/usr/local/bin/mjpg_streamer -i "input_raspicam.so" -o "output_http.so -w /usr/local/share/mjpg-streamer/www -p 8081"

test the stream :
http://192.168.1.xxx:8081/?action=stream

then create : 
sudo nano /etc/init.d/raspi-stream.sh
add this into :
<code>
#!/bin/sh
# /etc/init.d/mainsail-stream.sh
### BEGIN INIT INFO
# Provides:          mainsail-stream.sh
# Required-Start:    $network
# Required-Stop:     $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: mjpg_streamer for webcam
# Description:       Streams /dev/video0 to http://IP/?action=stream
### END INIT INFO
f_message(){
        echo "[+] $1"
}
 
# Carry out specific functions when asked to by the system
case "$1" in
        start)
                f_message "Starting mjpg_streamer"
                /usr/local/bin/mjpg_streamer -b -i "input_raspicam.so" -o "output_http.so -w /usr/local/share/mjpg-streamer/www -p 8081"-b 
                sleep 2
                f_message "mjpg_streamer started"
                ;;
        stop)
                f_message "Stopping mjpg_streamer…"
                killall mjpg_streamer
                f_message "mjpg_streamer stopped"
                ;;
        restart)
                f_message "Restarting daemon: mjpg_streamer"
                killall mjpg_streamer
                /usr/local/bin/mjpg_streamer -b -i "input_uvc.so" -o "output_http.so -w /usr/local/share/mjpg-streamer/www -p 8081"
                sleep 2
                f_message "Restarted daemon: mjpg_streamer"
                ;;
        status)
                pid=`ps -A | grep mjpg_streamer | grep -v "grep" | grep -v mjpg_streamer. | awk ‘{print $1}’ | head -n 1`
                if [ -n "$pid" ];
                then
                        f_message "mjpg_streamer is running with pid ${pid}"
                        f_message "mjpg_streamer was started with the following command line"
                        cat /proc/${pid}/cmdline ; echo ""
                else
                        f_message "Could not find mjpg_streamer running"
                fi
                ;;
        *)
                f_message "Usage: $0 {start|stop|status|restart}"
                exit 1
                ;;
esac
exit 0
</code>
sudo chmod 755 /etc/init.d/raspi-stream.sh
sudo sudo update-rc.d raspi-stream.sh

test service:
sudo service raspi-stream.sh start

Validate stream works 

configure the stream in fluidd 
