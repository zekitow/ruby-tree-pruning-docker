# Ruby Tree Pruning Docker
## Setup

1. Clone this repository
2. Build docker by running **docker-compose build** on terminal
3. Start docker in *test environment* using the command: **export RACK_ENV=test && docker-compose up && docker-compose logs -f**
4. Execute the tests using the command **docker exec rubytreepruningdocker_ruby_1 bundle exec rspec**

To make the setup easier to run:

```sh
# Clone the repository
git clone git@github.com:zekitow/ruby-tree-pruning-docker.git
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

Now you are able to access the url via [localhost](http://localhost:3000/tree/input)

## API Specification
## API /tree/:upstream

| Param            | Description                                 | Required  | Type     |
|------------------|---------------------------------------------|-----------|----------|
| upsteam          | The name of the tree to perform the search  | Yes       | String   |
| indicator_ids    | The refining indicator ids                  | No        | Array    |

### Curl Example

```sh
curl -v 'http://127.0.0.1:3000/tree/input?indicator_ids\[\]=2&indicator_ids\[\]=3'
```

Expected return example:
```json
[
  {
    "id":2,
    "name":"Demographics",
    "sub_themes":[
      {
        "categories":[
          {
            "id":11,
            "indicators":[
              {
                "id":2, // => refined indicator id
                "name":"male"
              },
              {
                "id":3, // => refined indicator id
                "name":"female"
              }
            ],
            "name":"Crude death rate",
            "unit":"(deaths per 1000 people)"
          }
        ],
        "id":4,
        "name":"Births and Deaths"
      }
    ]
  }
]
```

## Extra

IRB docker access:
```
cd web
docker exec -ti rubytreepruningdocker_ruby_1 bundle exec irb -r ./app.rb
```

Run guard:
```
docker exec -ti rubytreepruningdocker_ruby_1 bundle exec guard
```

Run rspec:
```
docker exec -ti rubytreepruningdocker_ruby_1 bundle exec rspec
```