# Ruby Tree Pruning Docker
## Setup

1. Clone this repository
2. Build docker by running **docker-compose build** on terminal
3. Start docker in *test environment* using the command: **export RACK_ENV=test && docker-compose up && docker-compose logs -f**
4. Execute the tests using the command **docker exec rubytreepruningdocker_ruby_1 bundle exec rspec**

To make the setup easier to run:

```sh
# Clone the repository
git@github.com:zekitow/ruby-tree-pruning-docker.git
cd ruby-tree-pruning-docker

# Build the docker (only needed for the first run)
docker-compose build

# Launch docker in test env
export RACK_ENV=test && docker-compose up && docker-compose logs -f

# On a new tab execute rspec tests
docker exec rubytreepruningdocker_ruby_1 bundle exec rspec
```

If everthing works fine, you should see the output similar to this:

```sh
HomeController
  GET /
    when I access the root page
      should eql 200
      should be empty

TreeController
  GET /tree
    when upstream is not sent
      should return 404 status
      should return not found body description

Finished in 0.12291 seconds (files took 0.38067 seconds to load)
27 examples, 0 failures
```

## API Specification
## API /tree

# TODO