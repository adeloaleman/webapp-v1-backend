# # # Python and venv

# Via APT: python, pip and venv
sudo apt install -y python3.11
sudo apt install -y python3-pip
sudo apt install -y python3.11-venv
python3.11 -m venv .venv

# Via Pyenv: python, pip and venv
pyenv -v
pyenv install --list
pyenv install 3.11.14
pyenv versions
pyenv local 3.11.14
python -m venv .venv

source .venv/bin/activate
which python
which pip
pip install --upgrade pip

# Installing libraries
touch requirements.txt
fastapi[standard]>=
SQLAlchemy>=
passlib>=
bcrypt>=
python-jose>=
python-dotenv>=
pydantic>=

pip install -r requirements.txt
pip list



# # # Github
https://github.com/adeloaleman -> webapp-fastapi.git
https://github.com/github/gitignore
touch .gitignore
touch README.md
git init
git branch -M main
git branch --show-current
git add .
git add -A
git commit -m "First commit"
git remote add origin git@github.com:adeloaleman/webapp-fastapi.git
git remote add origin git@github-codeastute:codeastute/webapp-fastapi.git
git remote set-url origin git@github.com:adeloaleman/webapp-fastapi.git
git remote show origin
git push -u origin main
git push --force origin main
git push
git clone git@github.com:adeloaleman/webapp-fastapi.git
git pull origin main



# # # FastAPI project
touch .env
AUTH_SECRET_KEY=
AUTH_ALGORITHM=HS256
API_URL=http://localhost:3000
touch Procfile
mkdir api
touch api/__init__.py
touch api/main.py
touch api/database.py
touch api/models.py
touch api/deps.py
mkdir api/routers
touch api/routers/__init__.py
touch api/routers/auth.py

fastapi run main.py --port 8000



mkdir .vscode
touch .vscode/settings.json
{
    "explorer.sortOrder": "filesFirst"
}