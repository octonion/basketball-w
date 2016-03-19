#!/bin/bash

psql basketball-w -f ncaa_sos/standardized_results.sql

psql basketball-w -c "drop table ncaa._basic_factors_geocoding;"
psql basketball-w -c "drop table ncaa._parameter_levels_geocoding;"

psql basketball-w -c "vacuum analyze ncaa.results;"

R --vanilla < ncaa_sos/ncaa_lmer_geocoding.R

psql basketball-w -f ncaa_sos/normalize_factors_geocoding.sql
psql basketball-w -f ncaa_sos/schedule_factors_geocoding.sql

psql basketball-w -f ncaa_sos/current_ranking.sql > ncaa_sos/current_ranking_geocoding.txt
psql basketball-w -f ncaa_sos/division_ranking.sql > ncaa_sos/division_ranking_geocoding.txt
