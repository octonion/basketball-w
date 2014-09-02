#!/bin/bash

psql rockets -f clean/add_ncaa_play_by_play_id.sql

psql rockets -f clean/add_ncaa_team_schedules_extra_fields.sql

psql rockets -f clean/generate_play_by_play_clean.sql

