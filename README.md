# JOB TASK

### Setup
Install docker https://docs.docker.com/engine/install/
To setup project on locale machine use following commands:

```
git clone git@github.com:djuks/job_task.git
cd job_task
docker-compose build
docker-compose run --rm api rails db:setup
```

Start server:

```
docker-compose up
```

## Development

To run Rspec tests or Rubocop tools use following commands:

```
docker-compose run --rm api rubocop
docker-compose run --rm api bundle exec rspec -fd
```

Generate api html docs use following command:

```
docker-compose run --rm \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    api rails docs:generate:html
```

To open rails console use following command:

```
docker-compose run --rm api rails c
```

To migrate database use following command:

```
docker-compose run --rm api rails db:migrate
```
