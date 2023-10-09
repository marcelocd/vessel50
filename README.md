# Vessel50

![Vessel50 Logo](logo.png)

Vessel50 is a robust Rails 7.1 application designed to efficiently scrape vessel tracking information from [VesselTracker](https://www.vesseltracker.com/en/vessels.html). This application provides a seamless experience for users looking to monitor vessel movements and related data.

![](vessel50.gif)

## Getting Started

These instructions will help you get a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

### Installation

1. Clone the repository to your local machine:

```sh
git clone https://github.com/marcelocd/vessel50.git
```

2. Navigate to the project directory:

```sh
cd vessel50
```

3. Build and launch the application with Docker Compose:

```sh
sudo docker-compose up --build
```

4. After the building process is done, access the application in your browser at `localhost:3000`.

## Features

- Seamless vessel tracking data scraping from [VesselTracker](https://www.vesseltracker.com/en/vessels.html).
- User-friendly interface for easy navigation and data retrieval.
- High performance and reliability powered by Rails 7.1.

## Usage

1. Upon launching the application, navigate to `localhost:3000`.
2. Click on the 'Scrape Trackings' button to start the scraping.
3. Open the sidebar clicking on the top right corner button and click on any option you like.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
