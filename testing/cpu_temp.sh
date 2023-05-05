#!/bin/bash
# depends on bc
# Initialize variables
total_temp=0
sensor_count=0

# Iterate through all thermal zones
for zone in /sys/class/thermal/thermal_zone*
do
  # Check if the type file exists for the current thermal zone
  if [ -f "$zone/type" ]; then
    # Read the type of the thermal zone
    type=$(cat "$zone/type")
    
    # Check if the type contains the string "x86_pkg_temp" for Intel or "k10temp" for AMD, which are relevant CPU sensors
    if [[ $type == *"x86_pkg_temp"* ]] || [[ $type == *"k10temp"* ]]; then
      # Check if the temp file exists for the current thermal zone
      if [ -f "$zone/temp" ]; then
        # Read the temperature value (in millidegrees Celsius) and convert it to degrees Celsius
        temp=$(cat "$zone/temp")
        temp=$(echo "scale=1; $temp / 1000" | bc)

        # Update the total temperature and sensor count
        total_temp=$(echo "$total_temp + $temp" | bc)
        sensor_count=$((sensor_count + 1))
      fi
    fi
  fi
done

# Calculate the average temperature
if [ $sensor_count -gt 0 ]; then
  average_temp=$(echo "scale=1; $total_temp / $sensor_count" | bc)
  echo "Average CPU Temperature: $average_temp °C"
else
  echo "No relevant CPU sensors found."
fi
