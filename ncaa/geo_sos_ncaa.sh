#!/bin/bash

psql basketball-w -f sos/standardized_results.sql

psql basketball-w -c "drop table ncaa._geo_basic_factors;"
psql basketball-w -c "drop table ncaa._geo_parameter_levels;"

R --vanilla < sos/geo_lmer.R

psql basketball-w -f sos/geo_normalize_factors.sql
psql basketball-w -f sos/geo_schedule_factors.sql

#psql basketball-w -f sos/connectivity.sql > sos/connectivity.txt
psql basketball-w -f sos/geo_current_ranking.sql > sos/geo_current_ranking.txt
#psql basketball-w -f sos/division_ranking.sql > sos/division_ranking.txt

#psql basketball-w -f sos/test_predictions.sql > sos/test_predictions.txt
