#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

steamcmd_dir="/steamcmd"
install_dir="/dst_server"
cluster_name="Cluster_1"
dontstarve_dir="/data"

function fail()
{
    echo Error: "$@" >&2
    exit 1
}

function check_for_file()
{
    if [ ! -e "$1" ]; then
        fail "Missing file: $1"
    fi
}

cd "$steamcmd_dir" || fail "Missing $steamcmd_dir directory!"

check_for_file "steamcmd.sh"
check_for_file "$dontstarve_dir/$cluster_name/cluster.ini"
check_for_file "$dontstarve_dir/$cluster_name/cluster_token.txt"
check_for_file "$dontstarve_dir/$cluster_name/Master/server.ini"
check_for_file "$dontstarve_dir/$cluster_name/Caves/server.ini"

# ./steamcmd.sh +force_install_dir "$install_dir" +login anonymous +app_update 343050 validate +quit
./steamcmd.sh +force_install_dir "$install_dir" +login anonymous +app_update 343050 +quit

cd "$install_dir"
rm -rf mods
ln -s /mods "$PWD"/mods

modoverrides="$dontstarve_dir/modoverrides"
if [ -f "$modoverrides" ]; then
    cp "$modoverrides" "$dontstarve_dir/$cluster_name/Master/
    cp "$modoverrides" "$dontstarve_dir/$cluster_name/Caves/
fi

cd "$install_dir/bin/" || fail

run_shared=(./dontstarve_dedicated_server_nullrenderer)
run_shared+=(-console)
run_shared+=(-persistent_storage_root "/")
run_shared+=(-conf_dir "$dontstarve_dir")
run_shared+=(-cluster "$cluster_name")
run_shared+=(-monitor_parent_process $$)

"${run_shared[@]}" -shard Caves  | sed 's/^/Caves:  /' &
"${run_shared[@]}" -shard Master | sed 's/^/Master: /'
