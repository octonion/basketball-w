#!/bin/bash

psql basketball-w -f sos/standardized_results.sql

psql basketball-w -c "drop table if exists ncaa._basic_factors;"
psql basketball-w -c "drop table if exists ncaa._parameter_levels;"

psql basketball-w -c "vacuum analyze ncaa.results;"

R --vanilla -f sos/lmer.R

psql basketball-w -c "vacuum full verbose analyze ncaa._basic_factors;"
psql basketball-w -c "vacuum full verbose analyze ncaa._parameter_levels;"

psql basketball-w -f sos/normalize_factors.sql

psql basketball-w -c "vacuum full verbose analyze ncaa._factors;"

psql basketball-w -f sos/schedule_factors.sql

psql basketball-w -c "vacuum full verbose analyze ncaa._schedule_factors;"

psql basketball-w -f sos/connectivity.sql > sos/connectivity.txt

psql basketball-w -f sos/current_ranking.sql > sos/current_ranking.txt
cp /tmp/current_ranking.csv sos/current_ranking.csv

psql basketball-w -f sos/division_ranking.sql > sos/division_ranking.txt

psql basketball-w -f sos/test_predictions.sql > sos/test_predictions.txt

psql basketball-w -f sos/predict_daily.sql > sos/predict_daily.txt
