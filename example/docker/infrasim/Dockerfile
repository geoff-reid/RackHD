# Copyright 2017, Dell Inc. 

FROM infrasim/infrasim-compute:3.5.1

COPY default.yml /root/.infrasim/.node_map
COPY start_node.sh /root/start_node.sh

ENTRYPOINT service ssh restart && /root/start_node.sh && bash

