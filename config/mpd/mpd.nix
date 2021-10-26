{
    home.file.".config/mpd/mpd.conf".text = "
music_directory		\"~/Media/Music\"
playlist_directory	\"~/Media/Music/playlists\"

db_file \"~/.config/mpd/mpd.db\"
log_file \"~/.config/mpd/mpd.log\"
pid_file \"~/.config/mpd/mpd.pid\"
state_file \"~/.config/mpd/mpdstate\"

auto_update \"yes\"
bind_to_address \"127.0.0.1\"
restore_paused \"yes\"
max_output_buffer_size \"16384\"

audio_output {
	type \"pulse\"
	name \"pulse\"
}

audio_output {
       type	\"fifo\"
       name	\"Visualizer feed\"
       path	\"/tmp/mpd.fifo\"
       format	\"44100:16:2\"
}
    ";
}
