# Instructions 

Install the following gems
```
gem install thor
gem install big_query
gem install dotenv
```

Run the following command on CLI
```
thor github:gh_repo_stats [--after DATETIME] [--before DATETIME] [--event EVENT_NAME] [-n COUNT]
```

## Responses to questions
1. To manage event types, I will use array.
2. To optimize the performance, I use Bigquery API from Google.
3. I use a private function called output_format to show different type of output.
4. I will use Thor gem to implement since it is only gem required to accomplish this task.
