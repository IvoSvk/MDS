async function fetchCameraData() {
    try {
        const response = await fetch('data/data.json');
        console.log(response)
        const cameras = await response.json();
        displayCameras(cameras);
    } catch (error) {
        console.error("Error fetching camera data:", error);
    }
}

function displayCameras(cameras) {
    const container = document.querySelector('.container');

    cameras.forEach(camera => {
        const cameraDiv = document.createElement('div');
        cameraDiv.className = 'camera';

        // Creating video element using Video.js
        const videoElement = document.createElement('video');
        videoElement.className = 'video-js vjs-default-skin';
        videoElement.setAttribute('controls', true);
        videoElement.setAttribute('preload', 'auto');
        videoElement.setAttribute('data-setup', '{}');

        const source = document.createElement('source');
        source.setAttribute('src', camera.stream_url);
        source.setAttribute('type', 'application/x-mpegURL'); // HLS format

        videoElement.appendChild(source);
        cameraDiv.appendChild(videoElement);

        container.appendChild(cameraDiv);

        // Initialize Video.js player
        videojs(videoElement);
    });
}

window.onload = fetchCameraData;
