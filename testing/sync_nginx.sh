#!/bin/bash

# Check if enough arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <github_user/repo_name> <domain_name>"
    exit 1
fi

# Split the first argument into github_user and repo_name
github_user_repo="$1"
IFS="/" read -ra ADDR <<< "${github_user_repo}"
github_user="${ADDR[0]}"
repo_name="${ADDR[1]}"
domain_name="$2"
branch_name="main"
web_root="/var/www/${domain_name}"
commit_file="${web_root}/.last_deployed_commit"

# Get the latest commit hash from the GitHub repository
latest_commit=$(curl -s -H "Accept: application/vnd.github+json" "https://api.github.com/repos/${github_user}/${repo_name}/commits/${branch_name}" | jq -r ".sha")

# If the commit file exists, read the commit hash from the file
if [ -f "${commit_file}" ]; then
    current_commit=$(cat "${commit_file}")
else
    touch "${commit_file}"
    current_commit=""
fi

# Compare the latest commit hash with the currently deployed commit hash
if [ "${latest_commit}" == "${current_commit}" ]; then
    echo "The latest commit is already deployed. No action required."
    exit 0
fi

# Create temp directory
temp_dir="/tmp/${github_user}-${repo_name}"
mkdir -p "${temp_dir}"
# Save current directory
CURR_PWD=$(pwd)
# Download repo content
echo "downloading: https://github.com/${github_user}/${repo_name}/archive/refs/heads/${branch_name}"
wget https://github.com/${github_user}/${repo_name}/archive/refs/heads/${branch_name}.zip -O "${temp_dir}/${repo_name}-${branch_name}.zip"
#curl -L "https://github.com/${github_user}/${repo_name}/archive/${branch_name}.tar.gz" | tar -xz -C "${temp_dir}"
cd "${temp_dir}"
unzip "${repo_name}-${branch_name}.zip"
#tar -xzf "${repo_name}-${branch_name}.tar.gz" 
ls -al "${temp_dir}/${repo_name}-${branch_name}"
ls -al "${temp_dir}"
cd "${CURR_PWD}"

# Synchronize content with webserver root
sudo mkdir -p ${web_root}
cd ${temp_dir}/${repo_name}-${branch_name}/app
npm update
npm install
npm run build
sudo rsync -a --delete "${temp_dir}/${repo_name}-${branch_name}/app/build/" "${web_root}/"

# Save the latest commit hash to the commit file
echo "${latest_commit}" > "${commit_file}"
#sudo chown www-data:www-data "${commit_file}"
#sudo chmod 640 "${commit_file}"

# Cleanup temp directory
cd ${CURR_PWD}
rm -rf "${temp_dir}"

# Print success message
echo "Content from ${github_user}/${repo_name} successfully synchronized with ${web_root}!"
