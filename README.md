# matrix-puppet-signal-docker

Docker compose file for matrix-puppet-signal. Fork from icewind1991/matrix-puppet-signal-docker image that is based on matrix-hacks/matrix-puppet-signal. You will need an iOS or Android device to link Signal to the bridge. Make 

## Usage

- Download the [sample config](https://github.com/matrix-hacks/matrix-puppet-signal/blob/master/config.sample.json)
- Fill in your personal config and rename to `config.json`
- Start signal link process `docker run -it --rm -v $(pwd)/config.json:/conf/config.json -v $(pwd)/data:/data icewind1991/matrix-puppet-signal-docker link`
- Scan the QR code with signal on your phone to finish registration. In job 136 after linking the device, the image will freeze. You can safely exit with Ctrl+C.
- Generate `signal-registration.yaml` using `docker run -it --rm -v $(pwd)/config.json:/conf/config.json icewind1991/matrix-puppet-signal-docker registration "http://matrix-signal:8090"`
- The output of `signal-registration.yaml` will appear on console. Copy it and create a signal-registration.yaml file on the same directory.
- Run the container with `docker run -it -v $(pwd)/config.json:/conf/config.json icewind1991/matrix-puppet-signal-docker`

## Usage with spantaleev/docker-ansible-matrix-deploy

- When you completed the steps above, the whole process will create data/ directory. Put its contents in /matrix/bridge-signal/data/ 
- Create directory /matrix/bridge-signal/config/ as per the docker-compose file structure. You can change this, but decided to go this way for ease of use and potential integration with the Ansible playbook from @spantaleev.
- Make sure the files have matrix:matrix as owner.
- Copy config.json and signal-registration.yaml onto /matrix/bridge-signal/config/ Also double check that ownership of the file is matrix:matrix
- Run the bridge with docker-compose from the repository.
- In the playbook, navigate to roles/matrix-synapse/defaults/main.yml and in variables matrix_synapse_container_additional_volumes: and matrix_synapse_container_additional_volumes: enter the following info:

`matrix_synapse_container_additional_volumes: - {"src": "/matrix/bridge-signal/config/signal-registration.yaml", "dst": "/signal-registration.yaml", "options": "ro"}`

`matrix_synapse_app_service_config_files: - /signal-registration.yml`

- Please note that the - before { in both values is included.
- Restart the playbook.

## Details

- Persitence data will be stored at `/data`

