@echo off
set VIDEO_URL=http://96.91.239.26:1024/mjpg/video.mjpg
set AUDIO_FILE=audio1.mp3
set TARGET_720=rtmp://localhost/hls/stream1_720
set TARGET_480=rtmp://localhost/hls/stream1_480
set TARGET_360=rtmp://localhost/hls/stream1_360



:: Start streaming video1
ffmpeg -r 2 -i %VIDEO_URL% -stream_loop -1 -i %AUDIO_FILE% ^
-filter_complex "[0:v]scale=1280:720,drawtext=fontfile=arial.ttf:text='720p':fontcolor=yellow:fontsize=72:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)-20:y=20[v720]; [0:v]scale=854:480,drawtext=fontfile=arial.ttf:text='480p':fontcolor=yellow:fontsize=72:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)-20:y=20[v480]; [0:v]scale=640:360,drawtext=fontfile=arial.ttf:text='360p':fontcolor=yellow:fontsize=72:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)-20:y=20[v360]" ^
-map "[v720]" -map 1:a -c:v libx264 -preset ultrafast -max_interleave_delta 0 -r 2 -maxrate 3000k -bufsize 6000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 192k -ac 2 -f flv %TARGET_720% ^
-map "[v480]" -map 1:a -c:v libx264 -preset ultrafast -max_interleave_delta 0 -r 2 -maxrate 2000k -bufsize 4000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 128k -ac 2 -f flv %TARGET_480% ^
-map "[v360]" -map 1:a -c:v libx264 -preset ultrafast -max_interleave_delta 0 -r 2 -maxrate 1000k -bufsize 2000k -pix_fmt yuv420p -g 50 -c:a aac -b:a 64k -ac 2 -f flv %TARGET_360%