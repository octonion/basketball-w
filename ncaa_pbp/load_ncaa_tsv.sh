#!/bin/bash

cmd="psql template1 --tuples-only --command \"select count(*) from pg_database where datname = 'basketball-w';\""

db_exists=`eval $cmd`
 
if [ $db_exists -eq 0 ] ; then
   cmd="createdb basketball-w"
   eval $cmd
fi

psql basketball-w -f loaders_tsv/create_ncaa_pbp_schema.sql

cp tsv/ncaa_teams_2015_1.tsv /tmp/ncaa_teams.tsv
psql basketball-w -f loaders_tsv/load_ncaa_teams.sql
rm /tmp/ncaa_teams.tsv

cp tsv/ncaa_team_schedules_mt_2015_1.tsv /tmp/ncaa_team_schedules.tsv
psql basketball-w -f loaders_tsv/load_ncaa_team_schedules.sql
rm /tmp/ncaa_team_schedules.tsv

cp tsv/ncaa_games_box_scores_mt_2015_1.tsv.gz /tmp/ncaa_games_box_scores.tsv.gz
gzip -d /tmp/ncaa_games_box_scores.tsv.gz
psql basketball-w -f loaders_tsv/load_ncaa_box_scores.sql
rm /tmp/ncaa_games_box_scores.tsv

cp tsv/ncaa_team_rosters_mt_2015_1.tsv /tmp/ncaa_team_rosters.tsv
psql basketball-w -f loaders_tsv/load_ncaa_team_rosters.sql
rm /tmp/ncaa_team_rosters.tsv

cp tsv/ncaa_games_periods_mt_2015_1.tsv /tmp/ncaa_games_periods.tsv
rpl "[" "{" /tmp/ncaa_games_periods.tsv
rpl "]" "}" /tmp/ncaa_games_periods.tsv
psql basketball-w -f loaders_tsv/load_ncaa_games_periods.sql
rm /tmp/ncaa_games_periods.tsv

cp tsv/ncaa_games_play_by_play_mt_2015_1.tsv.gz /tmp/ncaa_games_play_by_play.tsv.gz
gzip -d /tmp/ncaa_games_play_by_play.tsv.gz
psql basketball-w -f loaders_tsv/load_ncaa_games_play_by_play.sql
rm /tmp/ncaa_games_play_by_play.tsv
