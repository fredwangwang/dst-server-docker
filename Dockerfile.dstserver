FROM fredwanghuan/steamcmd

RUN /steamcmd/steamcmd.sh \
        +force_install_dir /dst_server \
        +login anonymous \
        +app_update 343050 \
        +quit

COPY ./scripts/start.sh /dst_server/start.sh

VOLUME [ "/data" , "/mods" ]

ENTRYPOINT ["/dst_server/start.sh"]
