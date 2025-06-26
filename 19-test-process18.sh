#!/bin/bash

while :; do
  x=$(yes "filling memory" | head -c 50M)  # Use up 50MB
  sleep 5
done
