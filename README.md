# Kubernetes Installation and App Deployment
This repository includes scripts and configurations for installing Kubernetes and deploying applications on Kubernetes. 
The working tree structure is as follows:

```
dev
├── .gitignore
├── 1.Kubernetes-Installation
│   └── README.md
├── 2.MySQL
│   ├── backup.sql
│   ├── Dockerfile
│   ├── mysql.yaml
│   ├── pv.yaml
│   ├── pvc.yaml
│   ├── README.md
│   ├── secret.yaml
│   └── storageclass.yaml
├── 3.PhpMyAdmin
│   ├── Dockerfile
│   └── phpmyadmin.yaml
├── 4.PostgreSQL
│   ├── .env
│   ├── docker-compose.yml
│   ├── postgres.yaml
│   ├── PostgreSQL.sql
│   ├── README.md
│   ├── Stored-Procedures
│   │   ├── daily_by_ssno.sql
│   │   ├── hourly_by_ssno.sql
│   │   ├── monthly_by_ssno.sql
│   │   ├── proc_data_by_dates.sql
│   │   ├── proc_data_by_hours.sql
│   │   ├── proc_data_by_months.sql
│   │   ├── proc_data_by_weeks.sql
│   │   ├── proc_summary.sql
│   │   └── weekly_by_ssno.sql
│   ├── Tables
│   │   ├── consumptions.sql
│   │   ├── data_by_dates.sql
│   │   ├── data_by_hours.sql
│   │   ├── data_by_months.sql
│   │   ├── data_by_weeks.sql
│   │   ├── firm_list.sql
│   │   ├── summary.sql
│   │   └── users.sql
│   ├── Trıgger-Function
│   │   ├── function_cons_data.sql
│   │   └── trigger_data_insert.sql
│   └── Views
│       ├── view_data_by_dates.sql
│       ├── view_data_by_hours.sql
│       ├── view_data_by_months.sql
│       ├── view_data_by_weeks.sql
│       └── view_summary.sql
├── 5.Adminer
│   └── adminer.yaml
├── 6.SQL-Server
│   ├── Dockerfile
│   ├── img
│   │   ├── ss1.png
│   │   ├── ss2.png
│   │   └── ss3.png
│   ├── README.md
│   ├── scripts
│   │   ├── daily_by_ssno.sql
│   │   ├── hourly_by_ssno.sql
│   │   ├── monthly_current_by_ssno.sql
│   │   ├── proc_data_by_dates.sql
│   │   ├── proc_data_by_hours.sql
│   │   ├── proc_data_by_months.sql
│   │   ├── proc_data_by_weeks.sql
│   │   ├── update_all_trigger.sql
│   │   └── weekly_by_ssno.sql
│   ├── sql.yaml
│   └── sqlserver.yaml
├── 7.Oracle
├── 8.Web_API-Node.js-Ngnix-React-UI
│   ├── client
│   │   ├── .env
│   │   ├── .gitignore
│   │   ├── Dockerfile
│   │   ├── jsconfig.json
│   │   ├── package-lock.json
│   │   ├── package.json
│   │   ├── public
│   │   │   ├── favicon.ico
│   │   │   ├── index.html
│   │   │   ├── logo192.png
│   │   │   ├── logo512.png
│   │   │   ├── manifest.json
│   │   │   └── robots.txt
│   │   ├── README.md
│   │   ├── src
│   │   │   ├── app
│   │   │   │   └── store.js
│   │   │   ├── App.js
│   │   │   ├── assets
│   │   │   │   └── profile.png
│   │   │   ├── components
│   │   │   │   ├── BarChart.jsx
│   │   │   │   ├── DailyTable.jsx
│   │   │   │   ├── DataGridCustomColumnMenu.jsx
│   │   │   │   ├── DataGridCustomToolbar.jsx
│   │   │   │   ├── FlexBetween.jsx
│   │   │   │   ├── FormAddUser.jsx
│   │   │   │   ├── FormEditUser.jsx
│   │   │   │   ├── Header.jsx
│   │   │   │   ├── HourlyTable.jsx
│   │   │   │   ├── Navbar.jsx
│   │   │   │   ├── StatBox.jsx
│   │   │   │   ├── TablesFinal.jsx
│   │   │   │   ├── usePagination.jsx
│   │   │   │   └── WeeklyTable.jsx
│   │   │   ├── config.js
│   │   │   ├── index.css
│   │   │   ├── index.js
│   │   │   ├── scenes
│   │   │   │   ├── admin
│   │   │   │   │   ├── AddUser.jsx
│   │   │   │   │   ├── EditUser.jsx
│   │   │   │   │   └── index.jsx
│   │   │   │   ├── dashboard
│   │   │   │   │   └── index.jsx
│   │   │   │   ├── detail
│   │   │   │   │   └── index.jsx
│   │   │   │   ├── layout
│   │   │   │   │   └── index.jsx
│   │   │   │   └── Login
│   │   │   │       └── Login.jsx
│   │   │   ├── state
│   │   │   │   ├── api.js
│   │   │   │   └── index.js
│   │   │   └── theme.js
│   │   └── webpack.config.js
│   ├── cons.yaml
│   ├── README.md
│   └── server
│       ├── .env
│       ├── config
│       │   └── Database.js
│       ├── config.js
│       ├── controllers
│       │   ├── Auth.js
│       │   ├── Daily.js
│       │   ├── Hourly.js
│       │   ├── Monthly.js
│       │   ├── Users.js
│       │   └── Weekly.js
│       ├── Dockerfile
│       ├── index.js
│       ├── middleware
│       │   └── AuthUser.js
│       ├── models
│       │   ├── Daily.js
│       │   ├── Hourly.js
│       │   ├── Monthly.js
│       │   ├── UserModel.js
│       │   └── Weekly.js
│       ├── package-lock.json
│       ├── package.json
│       ├── README.md
│       └── routes
│           ├── AuthRoute.js
│           ├── Daily.js
│           ├── Hourly.js
│           ├── SummaryRoute.js
│           ├── UserRoute.js
│           └── WeekslyRoute.js
└── README.md


```
