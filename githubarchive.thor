require 'thor'
require 'big_query'
require 'dotenv/load'

class Github < Thor
  EVENTS = ["CommitCommentEvent", "CreateEvent", "DeleteEvent", "DeploymentEvent", "DeploymentStatusEvent", "DownloadEvent", "FollowEvent", "ForkEvent", "ForkApplyEvent", "GistEvent", "GollumEvent", "InstallationEvent", "InstallationRepositoriesEvent", "IssueCommentEvent", "IssuesEvent", "LabelEvent", "MarketplacePurchaseEvent", "MemberEvent", "MembershipEvent", "MilestoneEvent", "OrganizationEvent", "OrgBlockEvent", "PageBuildEvent", "ProjectCardEvent", "ProjectColumnEvent", "ProjectEvent", "PublicEvent", "PullRequestEvent", "PullRequestReviewEvent", "PullRequestReviewCommentEvent", "PushEvent", "ReleaseEvent", "RepositoryEvent", "StatusEvent", "TeamEvent", "TeamAddEvent", "WatchEvent"]
  desc "gh_repo_stats [--after DATE_TIME ] [--before DATE_TIME] [--event EVENT_NAME] [--n COUNT] ", "Report repository statistic by github event type"
  method_option :event, :type => :string
  method_option :after, :type => :string
  method_option :before, :type => :string
  method_option :n, :type => :numeric

  def gh_repo_stats
   event = options[:event]
   after_date  = options[:after]
   before_date  = options[:before]
   count = options[:n]

   if !EVENTS.include?(event)
      puts "Event type is invalid"
      return
   else 
    output_report(event, after_date, before_date, count)
   end
  end

  private

   def output_report(event, after_date, before_date, count)
       stats =  get_stats(event, after_date, before_date, count)
       stats.each { |stat| output_format( stat[:repository_name], stat[:event_count])}
   end

   def output_format(name, count)
      puts "#{name} - #{count} events"
   end 

   def get_stats(event_type=nil, after_date=nil, before_date=nil, count=nil)
    opts = {}
    opts['client_id']     =  ENV['CLIENT_ID']
    opts['service_email'] =  ENV['SERVICE_EMAIL']
    opts['key']           =  ENV['KEY']
    opts['project_id']    =  ENV['PROJECT_ID']
    opts['dataset']       =  ENV['DATASET']

    query_str = "select repository_name, count(repository_name) as event_count from [githubarchive:github.timeline] where type='#{event_type}'"
    query_str += " and PARSE_UTC_USEC(created_at) > PARSE_UTC_USEC('#{after_date}')" unless from_date.nil?
    query_str += " and PARSE_UTC_USEC(created_at) < PARSE_UTC_USEC('#{before_date}')" unless to_date.nil?
    query_str += " group by repository_name order by event_count DESC"
    query_str += " limit #{count}" unless count.nil?

    bd = BigQuery::Client.new(opts)
    bd.query (query_str)
   end
end


