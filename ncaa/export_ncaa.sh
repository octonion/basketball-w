#!/bin/bash

#cd export

psql rockets -f export/export_box_scores.sql
psql rockets -f export/export_events.sql
psql rockets -f export/export_game_rosters.sql
psql rockets -f export/export_games.sql
psql rockets -f export/export_starters.sql

cp -f /tmp/ncaa_*.csv .
unix2dos ncaa_*.csv
rm -f ncaa_2014.zip
zip ncaa_2014.zip ncaa_*.csv
