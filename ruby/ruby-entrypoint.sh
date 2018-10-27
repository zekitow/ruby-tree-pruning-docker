#! /bin/bash

echo "[TREE PRUNING] Running RACK_ENV $RACK_ENV"
echo "[TREE PRUNING] Setting $APP_HOME"
cd $APP_HOME

echo "[TREE PRUNING] Running bundle..."
bundle check || bundle install --binstubs="$BUNDLE_BIN"

echo "[TREE PRUNING] Starting puma..."
bundle exec puma -p 3000

echo "[TREE PRUNING] Listening on port 3000"