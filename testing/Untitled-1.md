
pip install pymilvus redis


# ./run.sh -c -l 50 --allow-downloads


1. My Name is Shaun David Prince, I am from Vancouver Canada. I hold a PhD in Computer Science. On the internet I go by the name Suparious. Some websites identify me as shaun d. prince. I am a devops engineer, AWS Professional Solutions Architect and software developer. 
2. Search the web for anything related to me. Include all relevant social media accounts, projects, affiliations, open-source contributions etc.
3. based on all the information gatherered, create a super modern nodejs website that showcases an easy to navigate summary all of the gathered information. Include links to all relevant projects, affiliations and social media accounts.
4. git pull the latest suparious/suparious.com repo from github, move aside any conflicting files and / or folders and commit the new website.
5. Test the new website code locally to ensure it is user friendly and comprehensive, and that it is responsive on all devices.
6. Resolve any issues with the new website code, and commit the changes.
7. Push the new website code to the suparious.com repo.
8. repeat steps 5-7 until the website is perfect.



from pymilvus import connections
connections.connect(
  alias="default", 
  user='username',
  password='password',
  host='localhost', 
  port='19530'
)

My linkedin page is: https://www.linkedin.com/in/shaundprince/. My facebook page is: https://www.facebook.com/shaun.d.prince. My Quora page is: https://www.quora.com/profile/Shaun-Prince-6. My birthday is: April 16 1981.


CNTX={users|orgs}; NAME={username|orgname}; PAGE=1
curl "https://api.github.com/$CNTX/$NAME/repos?page=$PAGE&per_page=100" |
grep -e 'clone_url*' |
cut -d \" -f 4 |
xargs -L1 git clone
Set CNTX=users and NAME=yourusername, to download all your repositories.
Set CNTX=orgs and NAME=yourorgname, to download all repositories of your organization.
The maximum page-size is 100, so you have to call this several times with the right page

SupariousAI here!  I am at your service.

SupariousAI is: An AI designed to automomously develop and improve a personal blogging website that utilizes all of the latest technologoes and frameworks.

Goal 1: Create a report on the user Suparious. Include all of public and private github contributions, including those within the github orgs of Xerris and SolidRusT.
Goal 2: Based on your report about Suparious, determine a detailed plan for how to showcase all of their accomplishment and provide a space for suparious to blog.
Goal 3: review the detailed plan, and begin implementing an example to the local machine
Goal 4: review the locally deployed example to ensure it is meeting our requirements and make any improvements
Goal 5: create a detailed README.md file that explains how to install and configure the solution


curl https://github.com/suparious?tab=repositories | grep suparious | grep codeRepository | awk -F "\"" {' print $2 '}