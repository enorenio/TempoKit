# TempoKit - work management platform

![License](https://img.shields.io/github/license/enorenio/tempokit)
[![Repo Link](https://img.shields.io/badge/Repo-Link-green.svg)](https://github.com/enorenio/tempokit)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/enorenio/TempoKit)
![Nodejs Version](https://img.shields.io/badge/nodejs-12.16.3-brightgreen)
![Flutter Version](https://img.shields.io/badge/flutter-1.12.13%2Bhotfix.9-blue)

Work management platform that empowers your teams' workflow.
Helps you implement the Kanban team management methodology to improve your business productivity.
This is especially useful these days of remote work, where we all are trying our best.

Currently server is available [here](http://tempokit.azurewebsites.net/). But it is supposed to be used by app _only_.

## Features

- Makes multiple project management simple.
- Enhances your team productivity with Kanban methodology.
- See the work of each team, and of each member individually. Catch a freeloader in your company.
- Sort your tasks in columns.
- Discuss by writing comments in tasks.
- Mark your tasks with tags.
- Share the work with your colleague.
- Track your project completion by assigning due dates and milestones to tasks.
- Invite people to work together on a project.
- Keep files related to the task in its place.
- Create report on completed work.
- Elegant search throughout whole app.

## Quick start

### Prerequisites

This project uses [Flutter](https://flutter.dev/) and [Node js](https://nodejs.org/en/). Install them on your pc.

#### Clone this repo

```bash
git clone https://github.com/enorenio/TempoKit
cd tempokit
```

### Client Side

#### Install dependencies

```bash
flutter pub get
```

#### Run the app

Run the app [in the way your IDE describes](https://flutter.dev/docs/get-started/test-drive?tab=vscode).


#### Running the tests

This application was written partially using [Test-driven development](https://en.wikipedia.org/wiki/Test-driven_development)
There are **22 tests** in total, covering **100%** of used API calls. Every subsequent API call implementation should be tested before merge into master branch.

To run tests enter this command:

```bash
flutter test
```

### Server Side

#### Enter server directory.

```bash
cd server
```

#### Install dependencies

```bash
npm i
```

#### Run the server

In order for server to work, you should provide your system with these environment variables as the server depend on them:

```json
{
  "NODE_ENV": "development",
  "PORT": 3000,
  "BASE_URL": "http://localhost:3000",
  "SECRET": "provide your secret key",
  "LOGGING": true
}
```

Start your server with this command:

```bash
npm start
```

## Contributing

Contact existing contibutors to get access to contribute to this project.
Please follow Effective Dart formatting principles.
