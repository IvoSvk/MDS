fetch('./data/data.json')
    .then(response => response.json())
    .then(data => {
        console.log(data)
        const videoContainer = document.getElementById('video-container');

        data.forEach(item => {
            // Create video element
            let video = document.createElement('video');
            video.className = 'video-js';
            video.controls = true;
            video.width = 640;
            video.height = 264;

            // Create source element for video
            let source = document.createElement('source');
            source.src = item.stream_url;
            source.type = 'application/x-mpegURL';
            video.appendChild(source); // Append source to video

            videoContainer.appendChild(video);
            // Initialize Video.js on this video element
            videojs(video);

            // Synchronize audio with video playback

            video.ontimeupdate = () => video.currentTime;
            video.addEventListener('error', (e) => {
                console.error(`Error in video ${item.camera_id}:`, video.error);
            });

        });
    })
    .catch(error => console.log('Error fetching and parsing data', error));
