# sales-taxes

This is an application to import receipts in the form of csv files with their details and store to database. It then will be able to export them (also in the form of csv) with caculated details (price after tax of each item, tax amount, total). For the absence of a component to pre-create products, it is now first scanning the input csv and store those products into database. Receipts will then be created in database with ```product_id``` and other calculated details.

## Development

* Ruby version: 2.3.1

* Rails version: 5.2.0

* Database: PostgreSQL

Clone the repository to your local and run `bundle install` to install all necessary gems and dependencies

## Testing

- **Setup database:**

	- Database initilization: ```bundle exec bundle exec rake db:setup```
	- Run migrations to create tables: ```bundle exec bundle exec rake db:migrate```

- **Run test**: ```rspec```

