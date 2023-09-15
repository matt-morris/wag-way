# WagWay -- Walk. Wag. Woof.

## Overview

The WagWay API is a backend service designed to connect dog owners with dog walkers. With an emphasis on convenience and flexibility, the API allows users to find walkers based on location, availability, and price. Built on Ruby on Rails, this service utilizes the power of geolocation and complex SQL queries to provide a smooth and efficient user experience.

## Features

- **Geolocation-based Search**: Utilizes the Geocoder gem to find walkers within a certain radius of the owner's location.
- **Flexible Scheduling**: Allows users to search for available walkers based on specific time slots.
- **Price Filtering**: Walkers can set their own prices, allowing owners to choose based on their budget.
- **Walk Tracking**: Provides a model to track the status, location, and timing of each walk.

## Installation & Setup

1. Clone the repository.
2. Run `bundle install` to install dependencies.
3. Run `rails db:migrate` to apply database migrations.
4. Run `rails server` to start the development server.

## Testing

The API includes a suite of unit tests written with Minitest. Run the tests using the command:

```
rails test
```

## Contributing

If you'd like to contribute, please fork the repository and make changes as you'd like. Pull requests are warmly welcome.

## License

This project is licensed under the MIT License.

Happy Walking! 🐾
