import json

print("This program will validate the JSON training data.")

file = input("Enter the file name with extension: ")

# Load the JSON file
with open(file, "r", encoding="utf8") as f:
    data = json.load(f)

# Check each item in the JSON file
for item in data:
    if "instruction" not in item or "input" not in item or "output" not in item:
        print("Error: Missing key in JSON item.")
        print(item)

print("File done. ")
