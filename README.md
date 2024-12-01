# Marketplace Test ![Indonesia](https://raw.githubusercontent.com/stevenrskelton/flag-icon/master/png/36/country-4x3/id.png "Indonesia")
Testing Apps

> [!IMPORTANT]\
> TECHNOLOGY STACK :
<p align="left">
  <a><img src="https://img.shields.io/badge/v20.17.0-node-importantyellow?logo=nodedotjs" alt="NodeJs"></a>
  <a><img src="https://img.shields.io/badge/v18.3.1-react-blue?logo=react" alt="ReactJs"></a>
  <a><img src="https://img.shields.io/badge/v15.0.3-next-blueviolet?logo=nextdotjs" alt="NextJs"></a>
  <a><img src="https://img.shields.io/badge/v3.4.1-tailwind-yellow?logo=tailwindcss" alt="TailwindCss"></a>
  <a><img src="https://img.shields.io/badge/v3.14.0-restframework-red?logo=python" alt="DjangoRestFramework"></a>
  <a><img src="https://img.shields.io/badge/v5.0.3-django-teal?logo=django" alt="Django"></a>
  <a><img src="https://img.shields.io/badge/PostgreSQL v16.4.1-316192?logo=postgresql&logoColor=white" alt="Postgres"></a>
  <a><img src="https://img.shields.io/badge/v2024.1-kalilinux-purple?logo=linux" alt="Kali Linux OS"></a>
</p>

> Installation

Backend
```bash
# Create a virtual environment to isolate our package dependencies locally
> python3 -m venv venv
> source venv/bin/activate  # On Windows use `venv\Scripts\activate`
> (venv) pip install -r requirements.txt
# Sync Database, before migration set up the database connection in .env file
> (venv) python3 manage.py migrate v1
# Seeding data
> (venv) python3 manage.py loaddata fixtures/*.json
# Import PostgreSQL DB (file in dir /backend)
> psql -h 127.0.0.1 -U postgres -d marketplace -f marketplace.sql
```

Frontend
```bash
> npm install
```

> Running Local Development

Backend
```bash
> (venv) python3 manage.py runserver
```
Frontend
```bash
> npm run dev
```

> Build & Running

Frontend
```bash
> npm run build
> npm run start
```

> API Specs & Testing
See Swagger *http://127.0.0.1:8000/* and for API testing import file `marketplace.postman_collection.json` via Postman

Open a browser and access the web app at *http://localhost:3000/*