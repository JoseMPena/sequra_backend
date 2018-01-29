# README
This project is my answer to the Sequra backend challenge for hiring.

## The challenge
SeQura provides ecommerce shops (merchants) a flexible payment method so their customers (shoppers) can purchase and receive goods without paying upfront. SeQura earns a small fee per purchase and pays out (disburse) the merchant once the order is marked as completed.

The operations manager is now asking you to make a system to calculate how much money should be disbursed to each merchant based on the following rules:

* Disbursements are done weekly on Monday.
* We disburse only orders which status is completed.
* The disbursed amount has the following fee per order:
  * 1% fee for amounts smaller than 50 €
  * 0.95% for amounts between 50€ - 300€
  * 0.85% for amounts over 300€

## How to run the project:
In order to run this project, you shoul:
* a) clone or fork the repositor
* b) Install the dependencies `bundle install`
* c) Create the necessary data structure `rails db:migrate`

Note: To launch the background jobs in development, you should run `bundle exec rake jobs:work` on adding it to the console or the `delayed_jobs.rb` script file under /lib/

## Tests
In order to run the tests and ensure everything is working fine, run `rspec spec` on the console.

## Pending tasks:
Following tasks are pending as they couldn't be completed in specified timeframe:
* a) Ensure background jobs (disbursements) to be executed on Monday only
* b) Fine tune background Job tests
* c) Load merchant fixtures and modify tests to ensure required merchants are served thru the API endpoint
* d) General refactor, DRY out the code (remove repetitions), and more cleaning... 
