# FLOACT starter

This library is a monorepo template to create web-app application using this stack

- **[NextJS](https://nextjs.org/)** - as SSR web framework
- **[Flask](https://flask.palletsprojects.com/en/2.2.x/)** - as Rest API backend server
- **[StencilJS](https://stenciljs.com/)** - as UI library using web components

# Requirements

- [Python 3+](https://www.python.org/downloads/)
- [Nodejs 16+ / npm](https://nodejs.org/en/)

# Get started

- Run `rm -rf .git` to remove the git project
- Replace the following placeholders with your application name in the project folder (use CMD/CTRL + SHIFT + F as a find shortcuts in **VSCode**):
    - **FLOACT** -> **APPLICATION NAME IN UPPERCASE**
    - **floact** -> **application name in lowercase (use only alphacharacter)**
- Run `npm init` in the project root folder to install all the dependencies needed

# How to start local environment

- Run `npm start` in the project root folder to create a development local web server
    - Will build the UI components from **uilib** app
    - Will start the flask apis server from **server** app
    - Will start the NextJS web app from **client** app

# How to build the web app for production

- Run `npm build` in the project root folder to build the web application
    - Will build the UI components from **uilib** app
    - Will build the NextJS web app from **client** app

# How to use environments

- Create the file `envs/.env.[ENVIRONMENT_NAME]`
- Write the following scripts inside the `package.json` in the project root folder:
    - `"start:[ENVIRONMENT_NAME]":"concurrently \"yarn start:client:[ENVIRONMENT_NAME]\" \"yarn start:server:[ENVIRONMENT_NAME]\""` will start all the apps using [concurrently](https://www.npmjs.com/package/concurrently)
    - `"start:client:[ENVIRONMENT_NAME]": "yarn build:ui && cd apps/client && npm run build && ENV=[ENVIRONMENT_NAME] npm start"` will start the **client** app using the environment you want
    - `"start:server:[ENVIRONMENT_NAME]": "cd apps/server && ENV=[ENVIRONMENT_NAME] gunicorn --bind=0.0.0.0:3001 wsgi:app" `will start the **server** app using the environment you want
    - `"start:ui:[ENVIRONMENT_NAME]": "cd apps/uilib && ENV=[ENVIRONMENT_NAME] npm run start",` will start the **ui** app using the environment you want
- Run `yarn start:[ENVIRONMENT_NAME]` to launch all the apps
- **SIDE NOTES**:
    - Please try to mantain all the environemnt variables available in each environment
    - Three environments should be enough but eventually you can add/remove how many you like following the procedure above

# External libraries

It is a monorepo so you can keep the libraries in the root project (you can use **yarn** or **npm** as you prefer)

# UI library

The UI library is optional so you can keep it or remove it according the project requirements, here are some hints:

- The UI library is written using **Web Components** using **StencilJS** 
- All the **css variables** that define the global theme should be written inside the UI library
- If you choose to remove the UI library please remove all the references inside the **client** app