namespace :tweets do

  desc "fetch and process tweets @gyardley (didn't have @taskaroo)"
  task fetch: :environment do
    Mentions.add_tasks
  end

end