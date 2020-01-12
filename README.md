# matrix-puppet-signal-docker

Docker image for matrix-puppet-signal. Fork from icewind1991/matrix-puppet-signal-docker and based on matri-hacks/matrix-puppet-signal. You will need an iOS or Android device to link Signal to the bridge.

## Usage

- Download the [sample config](https://github.com/matrix-hacks/matrix-puppet-signal/blob/master/config.sample.json)
- Fill in the same config and rename to `config.json`
- Start signal link process `docker run -it --rm -v $(pwd)/config.json:/conf/config.json -v $(pwd)/data:/data icewind1991/matrix-puppet-signal-docker link`
- Scan the QR code with signal on your phone to finish registration. Exit after the device is linked with Ctrl+C.
- Generate `signal-registration.yaml` using `docker run -it --rm -v $(pwd)/config.json:/conf/config.json icewind1991/matrix-puppet-signal-docker registration "http://matrix-signal:8090"`
- The output of `signal-registration.yaml` will appear on console. Copy it and create a signal-registration.yaml file on the same directory.
- Run the bridge with docker-compose provided

## Usage with spantaleev/docker-ansible-matrix-deploy

## Details

- Persitence data will be stored at `/data`

